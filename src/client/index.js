'use strict';

require('ace-css/css/ace.css');
require('./style.css');
require('./Alert/style.css');


var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);
