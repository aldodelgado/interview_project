const path = require('path');

module.exports = {
  entry: './app/javascript/packs/application.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'public/packs'),
    publicPath: '/packs/',
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.css$/,  // Add this rule to handle CSS files
        use: ['style-loader', 'css-loader'],
      }
    ]
  },
  devServer: {
    static: {
      directory: path.resolve(__dirname, 'public'),
    },
    devMiddleware: {
      publicPath: '/packs/',
    },
    hot: true,
  }
};
