var Joi = require('joi');

module.exports = function(schema) {
  return function(req, res, next) {
    const joiOptions = {
      abortEarly: false
    };
    Joi.validate(req.body, schema, joiOptions, function (errors, value) {
      if (!errors || errors.details.length === 0) {
        return next();
      }
      errorObj = {}
      errors.details.forEach(function (error) {
        errorObj[error.path] = error.message;
      });
      res.badRequest(errorObj);
    });
  }
};
