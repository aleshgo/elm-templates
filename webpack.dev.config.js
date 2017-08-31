const webpack = require('webpack');
const path = require("path");

module.exports = {
  entry: {
    app: [
      'webpack-hot-middleware/client',
      './src/client/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/static/dist'),
    filename: 'main.js',
    publicPath: '/dist/'
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoEmitOnErrorsPlugin(),
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify(process.env.NODE_ENV || 'development')
      }
    })
  ],
  module: {
    rules: [
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          'elm-hot-loader',
          'elm-webpack-loader?forceWatch=true&verbose=true&warn=false&debug=false'
        ]
      },
      {
        test: /\.(css|scss)$/,
        use: [
          'style-loader',
          'css-loader',
        ]
      }
    ],

    noParse: /\.elm$/,
  }
};
