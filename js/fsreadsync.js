var fs = require('fs');

var dir = process.argv[2]

var data = fs.readdirSync(dir);
data.forEach(function (file) {
   console.log(file);
  })
