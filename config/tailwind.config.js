
module.exports = {
  darkMode: "class",
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        quicksand: ['Quicksand', 'sans-serif'],
      },
      animation: {
        'rotate-slow': 'rotate 1s linear infinite',
        'pulse-slow': 'pulse 1s linear infinite',
      },
      borderRadius: {
        'custom-radius': '43% 57% 63% 37% / 34% 78% 22% 66% '
      },
      shadow: {
        'custom-shadow': '0px 20px 30px rgba(0, 0, 0, 0.1)',
      },
      colors: {
        'primary1': "#8094D5",
        'custom-primary': "#FEAF9E",
        'custom-secondary': "#FEAF9C"
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require("rippleui")
  ]
}
