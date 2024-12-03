import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="topic-selector"
export default class extends Controller {
  static targets = ["userInput"]

  connect() {
    console.log("connected")
  }

  showInput(event) {
    console.log("show")
    console.log(event.currentTarget.value)
    if (event.currentTarget.value === "Choose your own topic") {
      this.userInputTarget.value = ''
      this.userInputTarget.classList.remove("d-none")
    } else {
      this.userInputTarget.classList.add("d-none")
      this.userInputTarget.value = event.currentTarget.value
    }
  }
}
