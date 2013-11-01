'use strict'

angular.module('bgtrackrApp')
.controller 'Login.RegisterCtrl', ($scope, $kinvey, $location) ->
    $scope.register = ()->
      delete $scope.error
      $kinvey.User.signup
        username: $scope.email
        email: $scope.email
        password: $scope.password
      .$promise.then ->
        $location.path '/'
      , (response)->
        $scope.error = response.data.description