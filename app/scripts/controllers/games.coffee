'use strict'

angular.module('bgtrackrApp')
.controller 'GamesCtrl', ($scope, $kinvey, $location) ->
    $kinvey.MyGames.query({}).$promise.then (rtn)->
      $scope.games = rtn
      console.log rtn
