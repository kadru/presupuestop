import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ "element" ]
  static classes = [ "toggle" ]

  toggle() {
    this.elementTargets.forEach((element) => element.classList.toggle(this.toggleClass))
  }
}
