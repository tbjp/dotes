import { Controller } from "@hotwired/stimulus"
// import { Popover } from "bootstrap";

// Connects to data-controller="popover"
export default class extends Controller {
  connect() {
    this.popover = new bootstrap.Popover(this.element, {
      title: this.element.dataset.bsTitle,
      content: this.element.dataset.bsContent,
      placement: this.element.dataset.bsPlacement || 'right',
      customClass: this.element.dataset.bsCustomClass || 'custom-popover',
    });
  }

  disconnect() {
    if (this.popover) {
      this.popover.dispose();
    }
  }
}
