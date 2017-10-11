const fs = require('fs');
const path = require('path');
const randomItem = require('../helpers/randomItem');
const dataFolder = path.join(__dirname, '../data');
const dataFile = path.join(dataFolder, "Questions.json");
const data = JSON.parse(fs.readFileSync(dataFile, 'utf8'));

exports.categoryTitles = function() {
    return data.categories.map(function(cat) {
        return cat.title;
    });
}

exports.randomQuestion = function(index) {
    var category = data.categories[index];
    return randomItem.get(category.questions);
}