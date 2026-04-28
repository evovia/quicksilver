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
    })

    this.panelTargets.forEach(panel => {
      const isActive = panel.dataset.tab === this.activeValue
      panel.classList.toggle("hidden", !isActive)
    })
  }
}
