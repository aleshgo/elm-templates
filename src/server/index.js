'use strict';

require('dotenv').config();
const express = require('express');
const path = require('path');
const cors = require('cors');
const renderIndex = require('./html').renderIndex;

// Express
const app = express();
const bodyparser = require('body-parser');
const response = require('./response');

// Middlewares
app.use(cors());
app.use(bodyparser.json());
app.use(response());

if (process.env.NODE_ENV == null) {
  process.env['NODE_ENV'] = 'development';
}

// If dev
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

// Load routers
const usersRouter = express.Router();
require('./routes/users')(usersRouter);
app.use('/api', usersRouter);

app.use('/', express.static(path.join(__dirname, '../..', 'static')));

app.get('/*', (req, res) =>
  res.status(200).end(renderIndex())
)

process.env.PORT = process.env.PORT || 3000;
const server = app.listen(process.env.PORT, (err) => {
  if (err) {
    console.log(err);
    return;
  }
  console.log('server listening on port: %s, env: %s', process.env.PORT, process.env.NODE_ENV);
});
