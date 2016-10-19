const jsonfile = require('jsonfile')
const user_schema = require('../validation/user')
const validate = require('../validate');
const _ = require('lodash');
const WT = require('../utils/webtoken')
const isAuthenticated = require('../utils/auth').isAuthenticated;

module.exports = function(router) {

  const file = process.env.DATA_FILE;
  const tokenExp = process.env.TOKEN_EXP;

  router.post('/users', validate(user_schema), function(req, res) {

    // read data
    jsonfile.readFile(file, function(err, users) {
      if(err) {
        users = []
      }

      var profile = _.pick(req.body, 'username', 'password');

      // check if user exists
      if (_.find(users, { username: profile.username })) {
        return res.badRequest({ username: "\"username\" already exists"});
      }

      // generate private_key & public_key
      const keyPair = WT.genKeyPair();
      // add to profile
      profile.publicKey = keyPair.getPublic();
      profile.privateKey = keyPair.getPrivate();

      // save profile
      users.push(profile);
      jsonfile.writeFile(file, users, function (err) {
        if(err) {
          return res.serverError(err);
        }
        return res.created({ token: WT.sign({ username: profile.username }, profile.privateKey, tokenExp)});
      });
    });
  });

  router.post('/sessions/create', validate(user_schema), function(req, res) {

    // read data
    jsonfile.readFile(file, function(err, users) {
      if(err) {
        return res.serverError(err);
      }

      const profile = _.find(users, { username: req.body.username });
      if(!profile || profile.password !== req.body.password) {
        return res.badRequest({ username: "\"username\" don't match",
                                password: "\"password\" don't match"});
      }

      return res.ok({ token: WT.sign({ username: profile.username }, profile.privateKey, tokenExp)});
    });
  });

  router.get('/sessions/test', isAuthenticated(file), function(req, res) {
    return res.ok();
  });

}
