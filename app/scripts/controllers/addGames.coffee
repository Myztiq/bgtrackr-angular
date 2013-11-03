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
      query:
        name: $scope.name
    .$promise.then (results)->
      for result in results
        do (result)->
          getGameById(result['$'].id).then (details)->
            result.details = details[0]
          console.log


      $scope.results = results
    , (err)->
      console.log err
      $scope.error = err



  getGameById = (id)->
    $kinvey.Games.query
      query:
        _id: id
    .$promise.then (details)->
      details
    , ->
      getGameById id
