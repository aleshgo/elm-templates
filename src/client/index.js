'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
require('./style.css');
require('./Alert/style.css');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);

app.ports.loadToken.send(localStorage.getItem('TOKEN') || sessionStorage.getItem('TOKEN') || "");

app.ports.saveToken.subscribe(function(tokenStorage) {
    if (tokenStorage.remember) {
        localStorage.setItem('TOKEN', tokenStorage.value);
    } else {
        sessionStorage.setItem('TOKEN', tokenStorage.value);
    }
});

app.ports.removeToken.subscribe(function() {
    localStorage.removeItem('TOKEN');
    sessionStorage.removeItem('TOKEN');
});

