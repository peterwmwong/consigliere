angular.module("consigliere").factory "SystemStatusResource", ($resource)->
  DBURL = "https://api.mongolab.com/api/1/databases/consigliere/collections/system-status/:id?apiKey=4cIC7N8HM4TTAeOHVNrR3CstB1eGJQ7z"
  STATID = '52962491e4b087bcc2df408e'
  SystemStatusResource = $resource DBURL, {id: STATID},
    updateStatus:
      method: 'PUT'
      transformRequest: ({status,issueStatus})->
        JSON.stringify {status,issueStatus}
