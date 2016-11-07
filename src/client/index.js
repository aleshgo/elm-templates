'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
require('./style.css');
require('./Alert/style.css');

var Elm = require('./Main.elm');

var storedModelStorage = localStorage.getItem('MODEL') || sessionStorage.getItem('MODEL') || null;
var modelStorage = storedModelStorage ? JSON.parse(storedModelStorage) : null;

var app = Elm.Main.fullscreen({ modelStorage : modelStorage, time : Date.now(), language : navigator.language});

app.ports.saveModel.subscribe(function(modelStorage) {
    localStorage.removeItem('MODEL');
    sessionStorage.removeItem('MODEL');

    if (modelStorage.remember) {
       localStorage.setItem('MODEL', JSON.stringify(modelStorage));
    } else {
       sessionStorage.setItem('MODEL', JSON.stringify(modelStorage));
    }

});

app.ports.removeModel.subscribe(function() {
    localStorage.removeItem('MODEL');
    sessionStorage.removeItem('MODEL');
});
