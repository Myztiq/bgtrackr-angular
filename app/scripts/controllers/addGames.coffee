'use strict'

angular.module('bgtrackrApp')
.controller 'AddGamesCtrl', ($scope, $kinvey, $location) ->

  $scope.select = (game)->
    console.log game
    $kinvey.MyGames.create
      gameId: game['@id']
      gameName: game.name['@value']
    $location.path('/games/mine')

  $scope.search = ()->
    $kinvey.Games.query
      name: $scope.name
    .$promise.then (results)->
      $scope.results = results