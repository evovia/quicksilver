import { Controller } from "@hotwired/stimulus"
import { useResize } from "stimulus-use"

export default class extends Controller {
  connect() {
    useResize(this, { element: this.element })
    this.resize()
  }

  input() {
    this.resize()
  }

  resize() {
    this.element.style.overflow = "hidden"
    this.element.style.height = "auto"
    this.element.style.height = `${this.element.scrollHeight}px`
  }
}
