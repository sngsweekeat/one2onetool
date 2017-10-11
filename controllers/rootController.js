const categories = require('../models/category');
const questions = require('../models/question');
const randomItem = require('../helpers/randomItem');

function getRandomFrom(items) {
    return items[Math.floor(Math.random()*items.length)];
}

module.exports = {
    showQuestion: function(req, res, next) {
        var cats = categories.getAll();
        var category = req.query.category ? req.query.category : randomItem.get(cats);
        var question = questions.getRandom(category);

        res.render('index', {
            title: '1to1tool',
            prompt: 'Having a 1-to-1 with your staff? Here\'s a question you could ask:',
            question: question,
            categories: cats,
            urlEncodedCategories: cats.map(encodeURIComponent)
        });            
    }
};

