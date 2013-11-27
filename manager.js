https = require('https');

var cur_status = true;

setInterval(function(){
  url = "https://api.mongolab.com/api/1/databases/consigliere/collections/system-status/52962491e4b087bcc2df408e?apiKey=4cIC7N8HM4TTAeOHVNrR3CstB1eGJQ7z"
  https.get(url, function(res){
    res.on('data', function (chunk) {
      var status = cur_status;
      try {
        status = JSON.parse(chunk.toString());
        status = status.issueStatus;
      }catch(e){}

      if (cur_status != status) {
        cur_status = status;
        console.log("CHANGE", status);

        var req = https.request({
          hostname: 'api.mongolab.com',
          path: '/api/1/databases/consigliere/collections/system-status/52962491e4b087bcc2df408e?apiKey=4cIC7N8HM4TTAeOHVNrR3CstB1eGJQ7z',
          method: 'PUT',
          headers: {
            "Content-Type": 'application/json'
          }
        }, function(res){
          res.on('data', function(data){
            console.log(data.toString());
          });
        });

        req.on('error', function(e) {
          console.log('problem with request: ' + e.message);
        });

        req.end('{"$set":{"status":'+cur_status+'}}');
      }
    });
  });
}, 5000);
