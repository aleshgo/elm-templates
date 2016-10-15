const WT = require('./webtoken');
const jsonfile = require('jsonfile')
const _ = require('lodash');

module.exports.isAuthenticated = function(file) {
  return function(req, res, next) {
    const token = req.query.token || req.headers.token || req.params.token;
    var username;

    try {
      username = WT.payload(token).username;
    } catch(err) {
      return res.unauthorzed();
    }

    jsonfile.readFile(file, function(err, users) {
      if(err) {
        console.log(err);
        return res.serverError(err);
      }

      const profile = _.find(users, { username });
      try {
        WT.verify(token, profile.publicKey);
      } catch(err) {
        return res.unauthorzed();
      }

      return next();
    });
  }
}
