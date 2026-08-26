import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tag"]

  connect() {
    this.disableTags();
  }

  enableTags() {
    this.tagTargets.forEach((tag) => tag.disabled = false);
  }

  disableTags() {
    this.tagTargets.forEach((tag) => tag.disabled = true);
  }
}
