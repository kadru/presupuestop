import { Controller } from "@hotwired/stimulus"
import Inputmask from "inputmask"

// Connects to data-controller="currency"
export default class extends Controller {
  static values = {
    digits: { type: Number, default: 2 }
  }

  connect() {
    Inputmask("currency",
              { prefix: "$",
                autoUnmask: true,
                removeMaskOnSubmit: true,
                rightAlign: false,
                digits: this.digitsValue
              }).mask(this.element)
  }

  disconnected() {
    Inputmask.remove(this.element)
  }
}
