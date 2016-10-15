const jsonfile = require('jsonfile')
const register_schema = require('../validation/register')
const validate = require('../validate');
const _ = require('lodash');


module.exports = function(router) {
  router.post('/users', validate(register_schema), function(req, res) {
    var file = process.env.DATA_FILE;

    // read data
    jsonfile.readFile(file, function(err, users) {
      if(err) {
        users = []
      }

      const profile = _.pick(req.body, 'username', 'password');

      // check if user exists
      if (_.find(users, { username: profile.username })) {
        return res.badRequest({ username: "\"username\" already exists"});
      }

      // add user
      users.push(profile);
      jsonfile.writeFile(file, users, function (err) {
        if(err) {
          return res.serverError(err);
        }
        return res.created({ TOKEN: 'token' });
      });
    });
  });
}
