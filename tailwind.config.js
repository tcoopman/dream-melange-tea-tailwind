const colors = require('tailwindcss/colors')

module.exports = {
  mode: 'jit',
  purge: [
    './client/**/*.ml',
    './client/**/*.js',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        sky: colors.sky,
        cyan: colors.cyan,
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
