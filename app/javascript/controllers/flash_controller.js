import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["close"]
  connect() {
    this.closeTarget.addEventListener("click", this.removeMessage.bind(this));
  }

  removeMessage() {
    this.element.remove();
  }


}
