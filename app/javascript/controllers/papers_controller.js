import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="papers"
export default class extends Controller {
  static targets = ["question", "paperForm"];
  static values = { currentIndex: Number };

  submitBtn = document.getElementById("submit-button");
  prevButton = document.getElementById("prev-button");
  nextButton = document.getElementById("next-button");
  preloader = document.getElementById("preloader");
  connect() {
    this.showQuestion(this.currentIndexValue);
  }

  showQuestion(index) {
    this.questionTargets.forEach((question, i) => {
      question.style.display = i === index ? "block" : "none";
    });

    this.updateButtons(index);
  }

  next(event) {
    event.preventDefault();
    if (this.currentIndexValue < this.questionTargets.length - 1) {
      this.currentIndexValue++;
      this.showQuestion(this.currentIndexValue);
    }
  }

  prev(event) {
    event.preventDefault();
    if (this.currentIndexValue > 0) {
      this.currentIndexValue--;
      this.showQuestion(this.currentIndexValue);
    }
  }

  updateButtons(index) {
    this.prevButton.disabled = index === 0;
    this.nextButton.disabled = index === this.questionTargets.length - 1;
  }

  submit(event) {
    event.preventDefault();
    this.preloader.classList.remove("hidden");
    this.preloader.classList.add("flex");
    setTimeout(() => {
      this.preloader.classList.add("hidden");
      this.paperFormTarget.submit();
    }, 10000);
  }

  checkRadio() {
    this.element.checked = true;
    setTimeout(() => {
      this.nextButton.click();
    }, 500)
  }



}
