const fs = require('fs');
const path = require('path');
const rl = require('readline');
const randomItem = require('../helpers/randomItem');
const dataFolder = path.join(__dirname, '../data');
const repo = require('./questionRepository');

exports.getRandom = function(category) {
    return repo.randomQuestion(category);
}


