const webpack = require('webpack');
const path = require("path");

module.exports = {
  entry: {
    app: [
      './src/client/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/static/dist'),
    filename: 'main.js',
    publicPath: '/dist/'
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify(process.env.NODE_ENV || 'production')
      }
    }),
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compressor: {
        warnings: false
      }
    })
  ],
  module: {
    loaders: [
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-hot!elm-webpack',
      },
    ],

    noParse: /\.elm$/,
  }
};
