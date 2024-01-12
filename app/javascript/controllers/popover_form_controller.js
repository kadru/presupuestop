import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.element.addEventListener("turbo:submit-end", this.submitEnd.bind(this))
  }

  submitEnd(event) {
    if(event.detail.success) {
      this.element.hidePopover()
    }
  }
}
