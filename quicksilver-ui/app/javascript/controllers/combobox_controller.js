import { Controller } from "@hotwired/stimulus"
import { useDebounce } from "stimulus-use"
import { useTransition } from "stimulus-use"
import { useKeyboardNavigation } from "mixins/use_keyboard_navigation"
import { useFloatingUI } from "mixins/use_floating_ui"
import { offset, flip, shift } from "@floating-ui/dom"

export default class extends Controller {
  static targets = ["input", "menu", "choice", "selectedItem", "hiddenInput",
    "selectedItemsContainer", "tagTemplate", "choicesContainer", "helpText",
    "searching", "noResults", "allChoicesSelected", "turboFrame"]
  static debounces = ["search"]
  static values = {
    placement: { type: String, default: "bottom-start" },
    shiftPadding: { type: Number, default: 8 },
    offset: { type: Number, default: 4 },
    multiple: { type: Boolean, default: false },
    busy: { type: Boolean, default: false },
    open: { type: Boolean, default: false },
    inputName: String,
    searchUrl: String
  }

  initialize() {
    useDebounce(this)
    useTransition(this, {
      element: this.menuTarget,
      hiddenClass: "hidden",
    })
    useKeyboardNavigation(this, this.inputTarget)
    useFloatingUI(this, this.inputTarget, this.menuTarget, this.positioningOptions)
  }

  connect() {
    this.hideAlreadySelectedChoices()
  }

  disconnect() {
    this.teardown()
  }

  teardown() {
    if (this.autoUpdateCleanup) {
      this.autoUpdateCleanup()
      this.autoUpdateCleanup = null
    }
  }

  async search() {
    const searchValue = this.inputTarget.value.trim()

    if (this.searchUrlValue) {
      await this.performAsyncSearch(searchValue)
    } else {
      this.performClientSearch(searchValue)
    }
  }

  async performAsyncSearch(searchValue) {
    if (searchValue.length === 0) {
      this.handleEmptySearch()
      return
    }

    this.prepareAsyncSearch()

    const response = await this.makeSearchRequest(searchValue)
    await this.handleSearchResponse(response)
    this.finalizeAsyncSearch()
  }

  performClientSearch(searchValue) {
    const hits = this.findMatchingChoices(searchValue)
    this.updateChoiceVisibility(hits)
    this.updateMenuAfterClientSearch()
  }

  handleEmptySearch() {
    this.showHelpText()
    this.hideTurboFrame()
    this.actuallyShowMenu()
  }

  prepareAsyncSearch() {
    this.hideTurboFrame()
    this.showSearchingMessage()
    this.actuallyShowMenu()
    this.setBusyState(true)
  }

  async makeSearchRequest(searchValue) {
    const url = this.buildSearchUrl(searchValue)

    return await fetch(url, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
  }

  buildSearchUrl(searchValue) {
    const url = new URL(this.searchUrlValue, window.location.origin)
    url.searchParams.set('q', searchValue)

    if (this.turboFrameTarget) {
      url.searchParams.set('frame_id', this.turboFrameTarget.id)
    }

    if (this.multipleValue && this.selectedItemValues.length > 0) {
      this.selectedItemValues.forEach(value => {
        url.searchParams.append('selected[]', value)
      })
    }

    return url
  }

  async handleSearchResponse(response) {
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }

    const turboStreamResponse = await response.text()

    this.hideMessages()
    this.showTurboFrame()
    Turbo.renderStreamMessage(turboStreamResponse)
  }

  showNoResults() {
    this.showNoResultsMessage()
    this.actuallyShowMenu()
  }

  finalizeAsyncSearch() {
    this.setBusyState(false)
  }

  findMatchingChoices(searchValue) {
    if (searchValue === "") {
      return this.choiceTargets
    }

    const searchTerms = this.getSearchTerms(searchValue)
    return this.choiceTargets.filter(choice =>
      this.choiceMatchesSearch(choice, searchTerms)
    )
  }

  getSearchTerms(searchValue) {
    return searchValue.toLowerCase().split(" ").filter(term => term.length > 0)
  }

  choiceMatchesSearch(choice, searchTerms) {
    const choiceText = choice.textContent.trim().toLowerCase()
    return searchTerms.some(term => choiceText.includes(term))
  }

  updateChoiceVisibility(matchingChoices) {
    this.choiceTargets.forEach(choice => {
      const isMatch = matchingChoices.includes(choice)
      const isSelected = this.isChoiceSelected(choice)

      if (isMatch && !isSelected) {
        choice.classList.remove("hidden")
      } else {
        choice.classList.add("hidden")
      }
    })
  }

  updateMenuAfterClientSearch() {
    if (this.visibleChoices.length > 0 && this.isInputFocused()) {
      this.showMenu()
    } else if (this.visibleChoices.length === 0) {
      this.showNoResultsMessage()
      this.actuallyShowMenu()
    }
  }

  showMenu() {
    this.openValue = true
  }

  actuallyShowMenu() {
    this.clearHideTimeout()
    this.enter()
    this.showWithPositioning()
  }

  hideMenu() {
    this.openValue = false
  }

  hideMenuWithDelay() {
    this.hideTimeout = setTimeout(() => this.hideMenu(), 150)
  }

  shouldShowHelpText() {
    return this.searchUrlValue && this.inputTarget.value.trim() === ""
  }

  shouldTriggerAsyncSearch() {
    return this.searchUrlValue &&
      this.visibleChoices.length === 0
  }

  clearHideTimeout() {
    if (this.hideTimeout) {
      clearTimeout(this.hideTimeout)
      this.hideTimeout = null
    }
  }

  selectChoice(event) {
    const choice = event.currentTarget
    const value = choice.dataset.value
    const displayValue = choice.textContent.trim()

    if (this.multipleValue) {
      this.handleMultipleSelection(value, displayValue)
    } else {
      this.handleSingleSelection(value, displayValue)
    }
  }

  selectHighlighted() {
    const visibleChoices = this.visibleChoices
    if (!this.isValidHighlightIndex(visibleChoices)) return

    const choice = visibleChoices[this.highlightedIndex]
    const value = choice.dataset.value
    const displayValue = choice.textContent.trim()

    if (this.multipleValue) {
      this.handleMultipleSelection(value, displayValue)
    } else {
      this.handleSingleSelection(value, displayValue)
    }
  }

  handleMultipleSelection(value, displayValue) {
    this.addSelection(value, displayValue)
    this.hideSelectedChoiceFromResults(value)
    this.inputTarget.focus()
  }

  handleSingleSelection(value, displayValue) {
    this.inputTarget.value = displayValue
    this.hiddenInputTarget.value = value
    this.hideMenu()
    this.inputTarget.focus()
  }

  addSelection(value, displayValue) {
    if (this.isSelectionUnique(value)) {
      let tag = this.createTagElement(value, displayValue)
      this.selectedItemsContainerTarget.appendChild(tag)
    }
  }

  hideAlreadySelectedChoices() {
    if (!this.multipleValue) return

    this.selectedItemValues.forEach(value => {
      this.hideSelectedChoiceFromResults(value)
    })
  }

  hideSelectedChoiceFromResults(value) {
    const choice = this.choiceTargets.find(choice => choice.dataset.value === value)
    if (choice) {
      choice.classList.add("hidden")
    }
    if (this.choiceTargets.every(choice => choice.classList.contains("hidden"))) {
      this.showAllChoicesSelectedMessage()
    }
  }

  showChoiceInResults(value) {
    const choice = this.choiceTargets.find(choice => choice.dataset.value === value)
    if (choice && this.choiceMatchesCurrentSearch(choice)) {
      choice.classList.remove("hidden")
    }
  }

  choiceMatchesCurrentSearch(choice) {
    const searchValue = this.inputTarget.value.trim()
    if (!searchValue) return true

    const searchTerms = this.getSearchTerms(searchValue)
    return this.choiceMatchesSearch(choice, searchTerms)
  }

  isSelectionUnique(value) {
    return !this.selectedItemValues.find(selectedValue => selectedValue === value)
  }

  isChoiceSelected(choice) {
    return this.multipleValue &&
      this.selectedItemValues.find(selectedValue => selectedValue === choice.dataset.value)
  }

  clearInput() {
    this.inputTarget.value = ""
  }

  refocusAndSearch() {
    setTimeout(() => {
      this.search()
      if (this.visibleChoices.length > 0) {
        this.showMenu()
      }
    }, 10)
    this.inputTarget.focus()
  }

  createTagElement(value, displayValue) {
    if (!this.hasTagTemplateTarget) return null

    const tag = this.cloneTagTemplate()
    this.populateTagContent(tag, value, displayValue)
    this.addHiddenInput(tag, value)

    return tag
  }

  cloneTagTemplate() {
    const tag = this.tagTemplateTarget.content.cloneNode(true).firstElementChild
    tag.removeAttribute("data-combobox-target")
    return tag
  }

  populateTagContent(tag, value, displayValue) {
    const textSpan = tag.querySelector("span")
    if (textSpan) {
      textSpan.textContent = displayValue
    }
  }

  addHiddenInput(tag, value) {
    const hiddenInput = document.createElement("input")
    hiddenInput.type = "hidden"
    hiddenInput.name = this.inputNameValue
    hiddenInput.value = value
    tag.appendChild(hiddenInput)
  }

  preventBlur(event) {
    event.preventDefault()
  }

  showHelpText() {
    this.showMessage(this.helpTextTarget)
  }

  showSearchingMessage() {
    this.showMessage(this.searchingTarget)
  }

  showNoResultsMessage() {
    this.showMessage(this.noResultsTarget)
  }

  showAllChoicesSelectedMessage() {
    this.showMessage(this.allChoicesSelectedTarget)
  }

  hideTurboFrame() {
    if (this.hasTurboFrameTarget) {
      this.turboFrameTarget.classList.add("hidden")
    }
  }

  showTurboFrame() {
    if (this.hasTurboFrameTarget) {
      this.turboFrameTarget.classList.remove("hidden")
    }
  }

  setBusyState(busy) {
    if (busy) {
      this.busyValue = true
      this.inputTarget.setAttribute("aria-busy", "true")
    } else {
      this.busyValue = false
      this.inputTarget.removeAttribute("aria-busy")
    }
  }

  showMessage(target) {
    this.hideMessages()
    target.classList.remove("hidden")
  }

  hideMessages() {
    this.messageTargets.forEach((messageTarget) => {
      messageTarget.classList.add("hidden")
    })
  }

  isInputFocused() {
    return document.activeElement === this.inputTarget
  }

  openValueChanged(value) {
    this.clearHideTimeout()

    if (value) {
      this.inputTarget.setAttribute("aria-expanded", "true")

      if (this.shouldShowHelpText()) {
        this.showHelpText()
        this.actuallyShowMenu()
        return
      }

      if (this.shouldTriggerAsyncSearch()) {
        this.search()
        return
      }

      if (this.visibleChoices.length === 0) {
        return
      }

      this.actuallyShowMenu()
    } else {
      this.inputTarget.setAttribute("aria-expanded", "false")
      this.leave()
      this.hideWithPositioning()
    }
  }

  get visibleChoices() {
    return this.choiceTargets.filter(choice => !choice.classList.contains("hidden"))
  }

  get isMenuVisible() {
    return !this.menuTarget.classList.contains("hidden")
  }

  get positioningOptions() {
    return {
      placement: this.placementValue,
      middleware: [
        offset(this.offsetValue),
        flip(),
        shift({ padding: this.shiftPaddingValue })
      ]
    }
  }

  get messageTargets() {
    return [
      this.helpTextTarget,
      this.noResultsTarget,
      this.searchingTarget,
      this.allChoicesSelectedTarget
    ]
  }

  get selectedItemValues() {
    return this.selectedItemTargets.map(item => item.querySelector("input").value)
  }
}
