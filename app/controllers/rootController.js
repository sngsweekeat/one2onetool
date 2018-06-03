const categories = require('../models/category');
const questions = require('../models/question');
const prompts = require('../models/prompt');
const randomItem = require('../helpers/randomItem');

module.exports = {
  showQuestion(req, res) {
    const cats = categories.getAll();
    const categoryIndex = req.query.category ? req.query.category : randomItem.getIndex(cats.length);
    const question = questions.getRandom(categoryIndex);
    const prompt = req.query.category ? prompts.getRandom(categoryIndex) : prompts.getRandom();

    res.render('index', {
      title: '1to1tool',
      prompt,
      question,
      categories: cats,
    });
  },
};

