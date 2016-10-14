const jsonfile = require('jsonfile')
const register_schema = require('../validation/register')
const validate = require('../validate');


module.exports = function(router) {
  router.post('/users', validate(register_schema), function(req, res) {
    var file = 'data.json'

    // read data
    jsonfile.readFile(file, function(err, users) {
      if(err) {
        return res.serverError(err);
      }
      // check if user exists

      // add user
      users.push(req.body);
      jsonfile.writeFile(file, users, function (err) {
        if(err) {
          return res.serverError(err);
        }
        return res.created({ JWT: 'ssss' });
      });
    });
  });
}
