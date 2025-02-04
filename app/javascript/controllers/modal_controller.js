import { Controller } from "@hotwired/stimulus"

// Maps functions to hide/open a dialog tag
// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["dialog"]

  open() {
    this.dialogTarget.showModal();
  }

  close(event) {
    this.dialogTarget.close();
  }
}
