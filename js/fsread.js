var fs = require('fs');

var dir = process.argv[2]

fs.readdir(dir, function(err, data) {
  if (err) {
   throw err;
  }
  else data.forEach(function (file) {
   console.log(file);
  })
});
