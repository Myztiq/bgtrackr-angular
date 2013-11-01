'use strict'

angular.module('bgtrackrApp')
  .controller 'Login.LoginCtrl', ($scope, $kinvey, $location) ->
    $scope.login = ()->
      delete $scope.error
      $kinvey.User.login
        username: $scope.email
        password: $scope.password
      .$promise.then ->
        $location.path '/'
      , (response)->
        $scope.error = response.data.description