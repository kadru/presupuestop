import { Controller } from "@hotwired/stimulus"

// Remove an element
// Connects to data-controller="removal"
export default class extends Controller {
  remove() {
    this.element.remove()
  }
}
