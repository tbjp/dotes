import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fade"
export default class extends Controller {
  static targets = [ "overlay" ]

  connect() {
    setTimeout(() => {
      this.overlayTarget.classList.add("fade-out")
    }, 300);
  }
  fadeIn(event) {
    console.log(event.currentTarget.href);
    event.preventDefault()
    console.log(this.overlayTarget);
    const url = event.currentTarget.href
    this.overlayTarget.classList.remove("fade-out")
    setTimeout(() => {
      window.location.href = url
    }, 300);
  }
}
