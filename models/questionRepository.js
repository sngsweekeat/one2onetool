const fs = require('fs');
const path = require('path');
const randomItem = require('../helpers/randomItem');

const dataFolder = path.join(__dirname, '../data');
const dataFile = path.join(dataFolder, 'Questions.json');
const data = JSON.parse(fs.readFileSync(dataFile, 'utf8'));

exports.categoryTitles = function categoryTitles() {
  return data.categories.map(cat => cat.title);
};

exports.randomQuestion = function randomQuestion(index) {
  const category = data.categories[index];
  return randomItem.get(category.questions);
};

exports.randomPrompt = function randomPrompt(index) {
  if (index) {
    const category = data.categories[index];
    return randomItem.get(category.prompts);
  }
  return randomItem.get(data.prompts);
};
