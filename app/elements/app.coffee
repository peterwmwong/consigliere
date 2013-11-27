require "../resources/SystemStatusResource.coffee"

elementify
  controller: ($scope, SystemStatusResource, $timeout)->
    constantlyUpdateStatus = ->
      $scope.status = SystemStatusResource.get()
      $timeout constantlyUpdateStatus, 5000
    constantlyUpdateStatus()

    $scope.$watch "status.issueStatus", (newStatus, oldStatus)->
      if newStatus? and oldStatus?
        $scope.status.issueStatus = newStatus
        $scope.status.$updateStatus()
