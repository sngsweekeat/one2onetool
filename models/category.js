const fs = require('fs');
const path = require('path');
const dataFolder = path.join(__dirname, '../data');

exports.getAll = function() {
    return fs.readdirSync(dataFolder);    
}
