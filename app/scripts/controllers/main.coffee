'use strict'

angular.module('bgtrackrApp')
  .controller 'MainCtrl', ($scope, $kinvey) ->
    $scope.user = $kinvey.User.current()
