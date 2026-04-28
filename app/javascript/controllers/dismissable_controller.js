import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use"

export default class extends Controller {
  static values = {
    autoDismissTime: Number,
    hiddenClass: { type: String, default: "tw:hidden" }
  }

  initialize() {
    if (this.hasAutoDismissTimeValue) {
      setTimeout(this.dismiss.bind(this), this.autoDismissTimeValue)
    }
  }

  connect() {
    useTransition(this, {
      element: this.element,
      enterActive: "tw:transition tw:ease-out tw:duration-300",
      enterFrom: "tw:transform tw:opacity-0 tw:scale-95",
      enterTo: "tw:transform tw:opacity-100 tw:scale-100",
      leaveActive: "tw:transition tw:ease-in tw:duration-300",
      leaveFrom: "tw:transform tw:opacity-100 tw:scale-100",
      leaveTo: "tw:transform tw:opacity-0 tw:scale-95",
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
