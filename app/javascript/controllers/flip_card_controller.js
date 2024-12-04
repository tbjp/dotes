import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["yes", "no"]

  flip(event) {
    if (event.target !== this.yesTarget && event.target !== this.noTarget) {
      this.element.classList.toggle("flipped")
    }
  }
}
