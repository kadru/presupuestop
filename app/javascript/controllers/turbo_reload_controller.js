import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-reload"
export default class extends Controller {
  static values = {
    frame: String
  }

  reloadFrame(event) {
    if(event.detail.success) {
      document.getElementById(this.frameValue).reload()
    }
  }
}
