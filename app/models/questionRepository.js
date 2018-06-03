const fs = require('fs');
const path = require('path');
const randomItem = require('../helpers/randomItem');

const dataFolder = path.join(__dirname, '../data');
const dataFile = process.env.DATA_FILE ? process.env.DATA_FILE : 'Questions.json';
const dataPath = path.join(dataFolder, dataFile);
const data = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

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
