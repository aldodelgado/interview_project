const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// Add additional plugins or loaders here as needed

// Enable Sass loader for using SCSS in your stylesheets
const sassLoader = environment.loaders.get('sass')
if (sassLoader) {
  sassLoader.use.find(item => item.loader === 'sass-loader').options.implementation = require('sass')
}

// Add jQuery or Bootstrap as needed
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
