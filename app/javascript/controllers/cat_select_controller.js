import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    target: { type: String, default: null }
  }

  async loadSubcategories() {
    const subcategories = await this.fetchSubcategories(this.element.value)
    const select = this.targetSelect()

    select.options.length = 0
    subcategories.forEach((subcat) =>
      select.add(new Option(subcat.name, subcat.id))
    )
  }

  targetSelect() {
    return document.getElementById(this.targetValue)
  }

  async fetchSubcategories(categoryId) {
    const response = await fetch(`categories/${categoryId}/subcategories`)
    return await response.json()
  }
}
