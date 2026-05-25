/**
 * useKeyboardNavigation stimulus mixin
 *
 * Adds keyboard navigation capabilities to a Stimulus controller for navigating through choices
 * Requires the controller to have:
 * - choiceTargets (array of selectable elements)
 * - menuTarget (container to check visibility)
 * - visibleChoices getter (filtered choices that are currently visible)
 * - isMenuVisible getter (boolean for menu visibility)
 * - showMenu() method
 * - selectHighlighted() method (callback for selection)
 * - hideMenu() method (callback for hiding menu)
 */

export const useKeyboardNavigation = (controller, input, options = {}) => {
  const {
    highlightClass = ["tw:bg-gray-200", "tw:text-gray-900"],
    ariaSelected = "aria-selected",
    scrollBehavior = { block: "nearest" }
  } = options

  controller.highlightedIndex = -1

  const isValidHighlightIndex = (visibleChoices) => {
    return controller.highlightedIndex >= 0 &&
      controller.highlightedIndex < visibleChoices.length
  }

  const clearAllHighlights = () => {
    controller.choiceTargets.forEach(choice => {
      choice.classList.remove(...highlightClass)
      choice.removeAttribute(ariaSelected)
    })
  }

  const highlightCurrentChoice = () => {
    const visibleChoices = controller.visibleChoices
    if (isValidHighlightIndex(visibleChoices)) {
      const choice = visibleChoices[controller.highlightedIndex]
      choice.classList.add(...highlightClass)
      choice.setAttribute(ariaSelected, "true")
      choice.scrollIntoView(scrollBehavior)
    }
  }

  const updateHighlight = () => {
    clearAllHighlights()
    highlightCurrentChoice()
  }

  const resetHighlightedIndex = () => {
    controller.highlightedIndex = -1
    updateHighlight()
  }

  const highlightNext = () => {
    const visibleChoices = controller.visibleChoices
    if (visibleChoices.length === 0) return

    controller.highlightedIndex = Math.min(
      controller.highlightedIndex + 1,
      visibleChoices.length - 1
    )
    updateHighlight()
  }

  const highlightPrevious = () => {
    const visibleChoices = controller.visibleChoices
    if (visibleChoices.length === 0) return

    controller.highlightedIndex = Math.max(controller.highlightedIndex - 1, 0)
    updateHighlight()
  }

  const selectAndHighlighNext = () => {
    controller.selectHighlighted()
    highlightNext()
  }

  const highlightFirst = () => {
    const visibleChoices = controller.visibleChoices
    if (visibleChoices.length === 0) return

    controller.highlightedIndex = 0
    updateHighlight()
  }

  const highlightLast = () => {
    const visibleChoices = controller.visibleChoices
    if (visibleChoices.length === 0) return

    controller.highlightedIndex = visibleChoices.length - 1
    updateHighlight()
  }

  const hideAndBlur = () => {
    controller.hideMenu()
    input.blur()
  }

  const handleKeydownWhenMenuHidden = (event) => {
    if (event.key === "ArrowDown" || event.key === "ArrowUp") {
      event.preventDefault()
      controller.showMenu()
    }
  }

  const keydown = (event) => {
    if (!controller.isMenuVisible) {
      return handleKeydownWhenMenuHidden(event)
    }

    const keyHandlers = {
      "ArrowDown": () => highlightNext(),
      "ArrowUp": () => highlightPrevious(),
      "Enter": () => selectAndHighlighNext(),
      "Escape": () => hideAndBlur(),
      "Tab": () => hideAndBlur(),
      "Home": () => highlightFirst(),
      "End": () => highlightLast()
    }

    const handler = keyHandlers[event.key]
    if (handler) {
      event.preventDefault()
      handler()
    }
  }

  Object.assign(controller, {
    keydown,
    highlightNext,
    highlightPrevious,
    highlightFirst,
    highlightLast,
    resetHighlightedIndex,
    updateHighlight,
    clearAllHighlights,
    highlightCurrentChoice,
    isValidHighlightIndex: (visibleChoices) => isValidHighlightIndex(visibleChoices)
  })
}
