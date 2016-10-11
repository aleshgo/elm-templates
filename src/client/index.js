'use strict';

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);

app.ports.loadBrowserLocale.send(localStorage.getItem('LOCALE') || navigator.language);

app.ports.saveBrowserLocale.subscribe(function(value) {
    localStorage.setItem('LOCALE', value);
});
