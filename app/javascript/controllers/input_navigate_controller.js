import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="input-navigate"
export default class extends Controller {
  nav(event) {
    event.target.form.submit()
  }
}
