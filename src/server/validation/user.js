var Joi = require('joi');

module.exports = {
  username: Joi.string().alphanum().min(6).max(40).required(),
  password: Joi.string().min(8).max(32).required()
};
