var express = require('express');
var app = express.createServer(express.logger());

app.get('/details', function(req, res) {
  res.render('details.ejs');
});

app.get('/', function(req,res) {
  res.render('index.ejs');
});

var port = process.env.PORT || 3000;

app.listen(port, function() {
  console.log("Listening on " + port);
});


app.configure('development', function() {
  app.use(express.static(__dirname + '/public'));
});
