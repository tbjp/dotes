import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["yes", "no", "form"]

  flip(event) {
    if (event.target !== this.yesTarget && event.target !== this.noTarget) {
      this.element.classList.toggle("flipped")
    }
  }

  correct(event) {
    event.preventDefault()
    const formData = new FormData()
    formData.append("flashcard[correct]", true)

    fetch(this.formTarget.action, {
      method: "PATCH", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
       },
      body: formData
    }).then(response => response.text())
      .then((data) => {
        this.formTarget.outerHTML = data
        this.element.classList.toggle("flipped")
      })

    console.log("works")
  }
}
