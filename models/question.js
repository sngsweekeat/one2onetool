const fs = require('fs');
const path = require('path');
const rl = require('readline');
const randomItem = require('../helpers/randomItem');
const dataFolder = path.join(__dirname, '../data');

exports.getRandom = function(category) {
    console.log('Getting question of category', category);
    var dataFile = path.join(dataFolder, category);
    var lines = fs.readFileSync(dataFile).toString().split('\n');
    var size = parseInt(lines[0]);
    var questions = lines.slice(1, size + 1);
    console.log(lines);
    console.log(questions);
    return randomItem.get(questions);
}


