import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use"
import { useFloatingUI } from "mixins/use_floating_ui"
import { offset, flip, shift } from "@floating-ui/dom"

export default class extends Controller {
  static targets = ["trigger", "menu"]
  static values = {
    placement: { type: String, default: "bottom-start" },
    shiftPadding: { type: Number, default: 8 },
    offset: { type: Number, default: 4 }
  }

  connect() {
    useTransition(this, {
      element: this.menuTarget,
      hiddenClass: "hidden",
    })
    this.actualTrigger = this.hasTriggerTarget ? this.triggerTarget : this.element

    useFloatingUI(this, this.actualTrigger, this.menuTarget, this.positioningOptions)
  }

  toggle() {
    if (this.menuTarget.classList.contains("hidden")) {
      this.show()
    } else {
      this.hide()
    }
  }

  show() {
    this.enter()
    this.showWithPositioning()
  }

  hide(event) {
    // If event is provided, check if click is outside dropdown
    if (event && this.element.contains(event.target)) {
      return
    }

    this.leave()
    this.hideWithPositioning()
  }

  // Private

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
}
