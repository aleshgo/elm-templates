'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
require('./style.css');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);

app.ports.loadToken.send(localStorage.getItem('TOKEN'));

app.ports.saveToken.subscribe(function(value) {
    localStorage.setItem('TOKEN', value);
});

app.ports.removeToken.subscribe(function() {
    localStorage.removeItem('TOKEN');
});

