module.exports = {
  purge: {
    // enabled: true, //comment this in to see purge in development
    content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue']
    // Add any other JS files here (i.e. .jsx, .ts, etc...)
    },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontSize: {'xxs': '.70rem'}
    },
  },
  variants: {},
  plugins: [],
}
