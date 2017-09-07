const express = require('express');
const router = express.Router();
const fs = require('fs');
const path = require('path');
const dataFolder = path.join(__dirname, '../data'); //TODO: better way to do this?

/* GET home page. */
router.get('/', function(req, res, next) {
    var categories = getCategories();
    console.log(categories);
    res.render('index', {
        title: '1to1tool',
        categories: categories
    });
});

function getCategories() {
    console.log(dataFolder);
    return fs.readdirSync(dataFolder);
}

module.exports = router;
