// general requires
var express = require('express');
var faker = require('faker');

// create the app
var app = express();

////////// authentication stuff
// requires
var cors = require('cors');
var expressJwt = require('express-jwt');
var jwt = require('jsonwebtoken');
var bodyParser = require('body-parser');

// database
var user = {
  username: 'admin',
  password: 'p'
};

// parse json data coming from client (used on login)
app.use(bodyParser.json());

// setup cors
app.use(cors());

// setup jwt
var jwtSecret = 'i3oifjda1322lr$#@08.';
app.use(expressJwt({ secret: jwtSecret }).unless({path: ['/login']}));

app.post('/login', authenticate, function(req, res) {
  var token = jwt.sign({
    username: req.user.username
  }, jwtSecret);

  res.json({
    token: token,
    user: {
      username : user.username
    }
  });
});

app.get('/me', checkAuthenticated, function(req, res) {
  res.json(req.user);
});

app.get('/random-user', checkAuthenticated, function(req, res) {
  var user = faker.Helpers.userCard();
  user.avatar = faker.Image.avatar();
  res.json(user);
});

app.listen(8000, function() {
  console.log('server listening on :8000');
});

// UTIL FUNCTIONS

function authenticate(req, res, next) {
  var body = req.body;
  if (!body.password || !body.username) {
    return res.status(400).end('Must provide password and username');
  }
  if (body.username !== user.username || body.password !== user.password) {
    return res.status(401).end('Username or password incorrect');
  }
  req.user = user;
  next();
}

function checkAuthenticated(req, res, next) {
  if (req.user) {
    next();
  } else {
    res.status(401).end('Must be authenticated');
  }
}