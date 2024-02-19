const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.{jsx,ts,tsx,js}',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    colors: {
      'body': '#1d1d1d',
      'dark-grey': '#374151',
      'grey': '#1f2831',
      'white': '#ffffff',
      'green': '#4ac3a7',
      'blue': '#4E8EC7',
      'purple': '#B577B0',
      'yellow': '#D6D6A2',
      'brown': '#C5836E',
      'red': '#C3313D',
      'dark-green': '#608E4D',
      'light-blue': '#8AC7E8'

    },
    screens: {
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      '2xl': '1536px',
    },
    extend: {
      fontFamily: {
        sans: ['Poppins', ...defaultTheme.fontFamily.sans],
      },
      backgroundImage: {
        close: "url('icons/close.svg')"
      },
      keyframes: {
        slide: {
          '0%': { transform: 'translateX(-100%)' },
          '100%': { transform: 'translateX(0%)' },
        },
        'grow-left': {
          '0%': { transform: 'scaleX(0)' },
          '80%': { transform: 'scaleX(1.1)' },
          '100%': { transform: 'scaleX(1)' },
        },
        'grow-down': {
          '0%': { transform: 'scaleY(0)' },
          '80%': { transform: 'scaleY(1.1)' },
          '100%': { transform: 'scaleY(1)' },
        },
        'shrink-up': {
          '0%': { transform: 'scaleY(1)' },
          '80%': { transform: 'scaleY(0.9)' },
          '100%': { transform: 'scaleY(0)' },
        }
      },
      animation: {
        slide: 'slide 0.3s forwards',
        'grow-left': 'grow-left 300ms ease-in-out forwards',
        'grow-down': 'grow-down 300ms ease-in-out forwards',
        'shrink-up': 'shrink-up 300ms ease-in-out forwards',
      }

    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
