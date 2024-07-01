// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"


// Add this to your JavaScript file
document.addEventListener("turbo:load", function () {
    const modalFrame = document.querySelector(".modal-frame");

    // Find and attach a click event handler to your trigger element
    const triggerElement = document.querySelector(".trigger-element"); // Replace with your actual trigger element
    triggerElement.addEventListener("click", function () {
        modalFrame.classList.toggle("hidden");
    });


    function detectDarkMode() {
        const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
        const html = document.querySelector('html');

        if (prefersDarkMode) {
            html.classList.add('dark');
        } else {
            html.classList.remove('dark');
        }
    }

    // Call the detectDarkMode function when needed
    detectDarkMode();
});
