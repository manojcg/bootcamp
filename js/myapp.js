var express = require('express')
var bodyparser = require('body-parser')
var fs = require('fs')
var url = require('url')
var app = express()
var htmlParser = bodyparser.urlencoded({
	extended: false
});
app.use(htmlParser);
app.get('/', function (req, res) {
	fs.readFile('index.html', function(err, data){
		if(err) throw err;
		res.writeHead(200, {"Content-Type": "text/html"});
		res.write(data.toString())
		res.end()			
	})
  
})

app.get('/time', function (req, res) {
	var parsedUrl = url.parse(req.url,  true);
	var d = new Date(parsedUrl.query.date);
	var val = {
		hour: d.getHours(),
		min: d.getMinutes(),
		sec: d.getSeconds()
	}

	res.writeHead(200, {"Content-Type": "application/json"});
	res.write(JSON.stringify(val));
	res.end();		
  
})
app.post('/hello.html', function(req, res){
	parsedUrl = url.parse(req.url, true);
	query = req.body;
	res.writeHead(200, {"Content-Type": "application/json"});
	res.write(JSON.stringify(query));
	res.end();
})

var server = app.listen(3000, function () {

  var host = server.address().address
  var port = server.address().port

  console.log('Example app listening at http://%s:%s', host, port)

})