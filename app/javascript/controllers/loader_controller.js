import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loader"
export default class extends Controller {

  preloader = document.getElementById("frame-preloader");
  connect() {
    // when some request sends addEventListener
    this.element.addEventListener("", this.showLoader);
    this.element.addEventListener("", this.hideLoader);
  }

  disconnect() {
    this.element.removeEventListener("", this.showLoader);
    this.element.removeEventListener("", this.hideLoader);
  }

  showLoader() {
    this.preloader.classList.remove("hidden");
  }

  hideLoader() {
    this.preloader.classList.add("hidden");
  }
}
