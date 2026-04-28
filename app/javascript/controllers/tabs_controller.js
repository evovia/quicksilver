import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = { active: { type: String, default: "preview" } }

  connect() {
    this.show()
  }

  switch(event) {
    this.activeValue = event.params.tab
  }

  keydown(event) {
    const tabs = this.tabTargets
    const index = tabs.indexOf(event.currentTarget)
    let newIndex

    switch (event.key) {
      case "ArrowRight":
        newIndex = (index + 1) % tabs.length
        break
      case "ArrowLeft":
        newIndex = (index - 1 + tabs.length) % tabs.length
        break
      case "Home":
        newIndex = 0
        break
      case "End":
        newIndex = tabs.length - 1
        break
      default:
        return
    }

    event.preventDefault()
    this.activeValue = tabs[newIndex].dataset.tabsTabParam
    tabs[newIndex].focus()
  }

  activeValueChanged() {
    this.show()
  }

  show() {
    this.tabTargets.forEach(tab => {
      const isActive = tab.dataset.tabsTabParam === this.activeValue
      tab.classList.toggle("bg-gray-900", isActive)
      tab.classList.toggle("border-gray-900", isActive)
      tab.classList.toggle("text-white", isActive)
      tab.classList.toggle("border-transparent", !isActive)
      tab.setAttribute("aria-selected", isActive)
      tab.setAttribute("tabindex", isActive ? "0" : "-1")
    })

    this.panelTargets.forEach(panel => {
      const isActive = panel.dataset.tab === this.activeValue
      panel.classList.toggle("hidden", !isActive)
    })
  }
}
