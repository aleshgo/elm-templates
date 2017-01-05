'use strict';

require('dotenv').config();
const express = require('express');
const path = require('path');

const cors = require('cors');
const app = express();

app.use(cors());
if (process.env.NODE_ENV === 'development') {
  const webpack = require('webpack');
  const webpackConfig = require ('../../webpack.dev.config.js');
  const compiler = webpack(webpackConfig);
  app.use(require('webpack-dev-middleware')(compiler, {
    noInfo: true,
    publicPath: webpackConfig.output.publicPath
  }));
  app.use(require('webpack-hot-middleware')(compiler));
}

app.use('/', express.static(path.join(__dirname, '../..', 'static')));

app.get('/*', function(req, res) {
  res.status(200).end(indexHtml);
})

process.env.PORT = process.env.PORT || 3000;
const server = app.listen(process.env.PORT, function(err) {
  if (err) {
    console.log(err);
    return;
  }
  console.log('server listening on port: %s, env: %s', process.env.PORT, process.env.NODE_ENV);
});

const indexHtml = `
  <html>
    <head>
      <meta charset="utf-8" />
      <title>Elm template</title>
      <link rel="icon" type="image/x-icon" href="/favicon.ico">
      <link rel="stylesheet" href="/font-awesome.min.css">
    </head>
    <body>
      <div id="main"></div>
      <script src="/dist/main.js"></script>
    </body>
  </html>
`
