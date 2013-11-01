'use strict'

angular.module('bgtrackrApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'ui.router',
  'kinvey'
])
  .config ($kinveyProvider, $stateProvider, $urlRouterProvider) ->

    # Init kinvey
    $kinveyProvider.init
      appKey: 'kid_VeBZfdqTmi'
      appSecret: 'ba86016e9def4609924bf629a189b6ec'


    # Set the default route
    $urlRouterProvider.otherwise("/")

    # Configure the routes for the app
    $stateProvider
      .state 'index',
        url: '/'
        secured: true
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'

      .state 'logout',
        url: '/logout'
        onEnter: ($location, $kinvey)->
          $kinvey.User.logout().$promise.then ->
            $location.path '/login'
          , ->
            $location.path '/login'

      .state 'login',
        url: '/login'
        views:
          "":
            templateUrl: '/views/login.html'
          'login@login':
            templateUrl: '/views/login/login.html'
            controller: 'Login.LoginCtrl'
          'register@login':
            templateUrl: '/views/login/register.html'
            controller: 'Login.RegisterCtrl'

      .state 'profile',
        url: '/profile'
        secured: true
        templateUrl: 'views/profile.html'
        controller: 'ProfileCtrl'

      .state 'myGames',
        url: '/games/mine'
        secured: true
        templateUrl: 'views/games/mine.html'
        controller: 'GamesCtrl'

      .state 'addGames',
        url: '/games/add'
        secured: true
        templateUrl: 'views/games/add.html'
        controller: 'AddGamesCtrl'

  # Configure the app itself
  .run ($rootScope, $location, $kinvey)->

    # Bind collections
    $kinvey.alias('MyGames', 'MyGames')
    $kinvey.alias('Games', 'Games')

    $rootScope.$on '$stateChangeStart', (evt, next, current)->
      $rootScope.user = $kinvey.User.current()
      $kinvey.User.current().$promise.then (resource)->
        isLoggedIn = resource.username?
        if next.secured and !isLoggedIn
          $location.path '/login'
        else if next.name == 'login' and isLoggedIn
          $location.path '/'
      , (err)->
        console.error('Unable to get user status.', err)
        if next.secured
          $location.path '/login'
