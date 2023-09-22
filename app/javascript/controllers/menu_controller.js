import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["mobileMenu"]


  menuIcon = document.querySelector("#menuIcon");

  connect() {
    // Add event listener to the document when the controller connects
    document.addEventListener("click", this.handleDocumentClick);
  }

  disconnect() {
    // Remove event listener from the document when the controller disconnects
    document.removeEventListener("click", this.handleDocumentClick);
  }

  toggleMenu() {
    this.mobileMenuTarget.classList.toggle("hidden");
    this.menuIcon.textContent = this.mobileMenuTarget.classList.contains("hidden") ? "menu" : "close";
  }

  handleDocumentClick = (event) => {
    // Check if the click event target is outside of the menu element
    if (!this.element.contains(event.target)) {
      this.mobileMenuTarget.classList.add("hidden");
      this.menuIcon.textContent = "menu";
    }
  }


}
