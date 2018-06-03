const express = require('express');
const router = express.Router();
const root = require('../controllers/rootController');

/* GET home page. */
router.get('/', function(req, res, next) {
    root.showQuestion(req, res, next);
});

module.exports = router;
