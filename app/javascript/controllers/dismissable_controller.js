import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use"

export default class extends Controller {
  static values = {
    autoDismissTime: Number,
    hiddenClass: { type: String, default: "hidden" }
  }

  initialize() {
    if (this.hasAutoDismissTimeValue) {
      setTimeout(this.dismiss.bind(this), this.autoDismissTimeValue)
    }
  }

  connect() {
    useTransition(this, {
      element: this.element,
      enterActive: "transition ease-out duration-300",
      enterFrom: "transform opacity-0 scale-95",
      enterTo: "transform opacity-100 scale-100",
      leaveActive: "transition ease-in duration-300",
      leaveFrom: "transform opacity-100 scale-100",
      leaveTo: "transform opacity-0 scale-95",
      hiddenClass: this.hiddenClassValue,
      transitioned: true
    })
  }

  dismiss() {
    this.leave().then(() => {
      this.element.remove()
    })
  }
}
