const fs = require('fs');
const path = require('path');
const dataFolder = path.join(__dirname, '../data'); //TODO: better way to do this?
const rl = require('readline');

function getCategories() {
    return fs.readdirSync(dataFolder);
}

function getRandomFrom(items) {
    return items[Math.floor(Math.random()*items.length)];
}

function getQuestionOfCategory(category) {
    console.log('Getting question of category', category);
    var dataFile = path.join(dataFolder, category);
    var lines = fs.readFileSync(dataFile).toString().split('\n');
    var size = parseInt(lines[0]);
    var index = Math.floor(Math.random()*size) + 1;
    return lines[index];
}

module.exports = {
    showQuestion: function(req, res, next) {
        var categories = getCategories();
        var category = req.query.category ? req.query.category : getRandomFrom(categories);
        var question = getQuestionOfCategory(category);

        res.render('index', {
            title: '1to1tool',
            prompt: 'Having a 1-to-1 with your staff? Here\'s a question you could ask:',
            question: question,
            categories: categories,
            urlEncodedCategories: categories.map(encodeURIComponent)
        });            
    }
};

