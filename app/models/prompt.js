const repo = require('./questionRepository');

exports.getRandom = function getRandom(category) {
  return repo.randomPrompt(category);
};
