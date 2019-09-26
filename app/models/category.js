const repo = require('./questionRepository');

exports.getAll = function() {
    return repo.categoryTitles();
}
