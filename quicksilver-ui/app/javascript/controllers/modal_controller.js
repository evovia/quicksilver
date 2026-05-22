import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]
  static values = { open: Boolean }

  initialize() {
    this.forceClose = this.forceClose.bind(this)
  }

  connect() {
    document.addEventListener("turbo:before-render", this.forceClose)

    if (this.openValue) {
      this.open()
    }
  }

  disconnect() {
    document.removeEventListener("turbo:before-render", this.forceClose)
  }

  open() {
    this.dialogTarget.showModal()
  }

  close() {
    this.dialogTarget.setAttribute("closing", "")

    Promise.all(this.dialogTarget.getAnimations().map((animation) => animation.finished)).then(() => {
      this.dialogTarget.removeAttribute("closing")
      this.dialogTarget.close()
    })
  }

  backdropClose(event) {
    if (event.target === this.dialogTarget) {
      this.close()
    }
  }

  forceClose() {
    this.dialogTarget.close()
  }
}
