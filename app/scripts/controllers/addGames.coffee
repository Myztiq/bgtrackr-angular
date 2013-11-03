'use strict'

angular.module('bgtrackrApp')
.controller 'AddGamesCtrl', ($scope, $kinvey, $location) ->

  $scope.select = (game)->
    $kinvey.MyGames.create
      gameId: game['$'].id
      gameName: game.name[0]['$'].value
    $location.path('/games/mine')

  $scope.search = ()->
    getGamesByName($scope.name).then (results)->
      for result in results
        do (result)->
          getGameById(result['$'].id).then (details)->
            result.details = details[0]
      $scope.results = results
    , (err)->
      $scope.error = err



  getGamesByName = (name)->
    $kinvey.Games.query
      query:
        name: $scope.name
    .$promise.then (results)->
      results
    , ->
      getGamesByName name


  getGameById = (id)->
    $kinvey.Games.query
      query:
        _id: id
    .$promise.then (details)->
      details
    , ->
      getGameById id
