angular.module('anime', ['ng-token-auth', 'ngRoute'])
.config(function ($authProvider, $httpProvider, $routeProvider) {
  $authProvider.configure({
    apiUrl: 'http://localhost:3000'
  });

  $routeProvider
  .when('/shows',{
      controller: 'ShowController',
      templateUrl: 'shows.html'
   }).otherwise({
    controller: 'UserController',
    templateUrl: 'sign_in.html'
  })
});

