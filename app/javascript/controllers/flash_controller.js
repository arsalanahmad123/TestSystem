import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["closeIcon"]
  connect() {
  }

  initialize() {
    this.closeIconTarget.setAttribute("data-action", "click->flash#removeMessage");
  }

  removeMessage() {
    this.element.remove();
  }


}
