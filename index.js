const express = require('express');
const app = express();

app.get('/', function (req, res) {
  res.send('Hello World!');
});

var port = process.env.PORT || '3000';
app.set('port', port);

app.listen(port, function () {
  console.log('Example app listening on port ' + port);
});
