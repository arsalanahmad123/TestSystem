import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="papers"
export default class extends Controller {
  static targets = ["question", "paperForm"];
  static values = { currentIndex: Number };

  submitBtn = document.getElementById("submit-button");
  prevButton = document.getElementById("prev-button");
  nextButton = document.getElementById("next-button");
  preloader = document.getElementById("preloader");

  countDown = document.getElementById("countdown-timer");

  connect() {
    this.showQuestion(this.currentIndexValue);
    this.startCountDown();
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
    }, 3000);
  }

  checkRadio() {
    this.element.checked = true;
    setTimeout(() => {
      this.nextButton.click();
    }, 500)
  }


  startCountdown() {
    let countdownMinutes = 1;
    let remainingTime = this.countdownMinutes * 60; // Convert minutes to seconds

    // Update the countdown timer element every second
    this.countdownInterval = setInterval(() => {
      const minutes = Math.floor(remainingTime / 60);
      const seconds = remainingTime % 60;

      // Display the remaining time in the format "mm:ss"
      this.countDown.textContent = `${minutes
        .toString()
        .padStart(2, "0")}:${seconds.toString().padStart(2, "0")}`;

      remainingTime--;

      // When the countdown reaches 0, submit the paper form
      if (remainingTime < 0) {
        this.countDown.textContent = "Time's up!";
        this.preloader.classList.remove("hidden");
        this.preloader.classList.add("flex");
        setTimeout(() => {
          this.preloader.classList.add("hidden");
          this.paperFormTarget.submit();
        }, 3000);

        clearInterval(this.countdownInterval);
      }
    }, 1000); // Update every second
  }



}
