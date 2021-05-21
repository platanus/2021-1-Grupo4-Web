/* eslint-disable no-undef */
module.exports = {
  theme: {
    extend: {
      colors: {
        black: '#0A000A',
        gray: {
          '800': '#27272A',
          '600': '#847974',
          '200': '#E4E1E0',
          '900': '#262626',
        },
        yellow: {
          '500': '#DCAB24',
        },
        green: {
          '500': '#2B8E65',
        },
      },
    },
  },
  variants: {
    extend: {
      opacity: ['disabled'],
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
  purge: {
    enabled: process.env.NODE_ENV === 'production',
    content: [
      './app/**/*.html',
      './app/**/*.vue',
      './app/**/*.js',
      './app/**/*.erb',
    ],
  },
};
