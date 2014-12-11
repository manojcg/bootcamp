
var cluster = require('cluster')
if(cluster.isMaster){

    // Count the machine's CPUs
    var cpuCount = require('os').cpus().length;

    // Create a worker for each CPU
    for (var i = 0; i < cpuCount; i += 1) {
        cluster.fork();
    }

}
else {
	var express = require('express')
	var bodyparser = require('body-parser')
	var fs = require('fs')
	var url = require('url')
	var app = express();
	app.get("/", function(req, res){
		res.send('Hello World' + cluster.worker.id);
	});
	var server = app.listen(3000, function () {
		var host = server.address().address
		var port = server.address().port

		console.log('Example app listening at http://%s:%s - Worker : %s', host, port,cluster.worker.id);

	});
}

