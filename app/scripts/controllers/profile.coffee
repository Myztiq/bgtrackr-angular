'use strict'

angular.module('bgtrackrApp')
  .controller 'ProfileCtrl', ($scope, $kinvey) ->
    $scope.user = $kinvey.User.current()

    $scope.save = ->
      console.log $scope.user
      $kinvey.User.save($scope.user)