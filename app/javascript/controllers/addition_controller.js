import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="addition"
export default class extends Controller {
  static targets = ["addend", "sum"]

  add() {
    this.sumTarget.value = this.#sumAddends();
  }

  #sumAddends() {
    return this.addendTargets.map((addendField) => {
      const num = parseInt(addendField.value)
      if (isNaN(num))
        return 0;
      else
        return num;
    }).reduce((accum, addend) => accum + addend);
  }
}
