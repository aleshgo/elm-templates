const _ = require('lodash');

module.exports = function() {
  return function(req, res, next) {

    function meta(success, status) {
      return { meta: { success , status } }
    }

    res.ok = function(obj) {
      return res.json(_.assign(obj, meta(true, res.statusCode)));
    }

    res.created = function(obj) {
      res.status(201);
      return res.ok(obj);
    }

    res.badRequest = function(obj) {
      res.status(400);
      return res.json(_.assign(obj, meta(false, res.statusCode)));
    }

    res.unauthorzed = function(obj) {
      res.status(401);
      return res.json(meta(false, res.statusCode));
    }

    res.forbidden = function(obj) {
      res.status(403);
      return res.json(meta(false, res.statusCode));
    }

    res.serverError = function(err) {
      console.log(err);
      return res.status(500).json(meta(false, 500));
    }

    next();
  }
};
