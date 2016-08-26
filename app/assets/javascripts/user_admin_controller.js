angular.module('anime')
.controller('UserAdminController', function ($scope, $auth, $http, $rootScope, $location) {
  $scope.fetch_random = function () {
    $http({
      url: '/shows/rand',
      method: 'GET',
      headers: $auth.retrieveData('auth_headers')
    }).then( function (e){
      console.log(e);
      $scope.show = e.data; 
    });
  }

  $scope.new_random = function () {
    $http({
      url: 'shows/new-random',
      method: 'POST',
      headers: $auth.retrieveData('auth_headers')
    }).then( function (e) {
      console.log(e);
      $scope.show = e.data;
    });
  }

  $scope.remove_random = function() {
    $http({
      url: 'shows/remove-random',
      method: 'POST',
      headers: $auth.retrieveData('auth_headers')
    }).then( function (e) {
      console.log(e);
      $scope.show = e.data;
    });
  }

  $scope.reset_all_votes = function() {
    $http({
      url: 'votes/reset',
      method: 'DELETE',
      headers: $auth.retrieveData('auth_headers')
    }).then(function (e){
      console.log('done');
    });
  }

  $scope.reset_weekly_votes = function() {
    $http({
      url: 'votes/reset-weekly',
      method: 'DELETE',
      headers: $auth.retrieveData('auth_headers')
    }).then(function (e) {
      console.log('done');
    });
  }

  $scope.fetch_config = function (){
    $http({
      url: 'vote-config/1',
      method: 'GET',
      headers: $auth.retrieveData('auth_headers')
    }).then(function(e){
      console.log(e);
      $scope.config = e.data;

      console.log($scope.config.timezone);
    });
  }

  $scope.update_config = function (){
    $http({
      url: 'vote-config/1',
      method: 'PATCH',
      headers: $auth.retrieveData('auth_headers'),
      params: {
        stop_voting_time: $scope.config.stop_voting_time,
        stop_voting_day: $scope.config.stop_voting_day,
        timezone: $scope.config.timezone
      }
    }).then(function (e) {
      console.log(e)
      $scope.error = false;
    }, function (e) {
      $scope.error = "Invalid Configuration"
    });
  }

  $scope.toggle_voting = function (active) {
    $http({
      url: 'vote-config/1/toggle-voting',
      method: 'PATCH',
      headers: $auth.retrieveData('auth_headers'),
      params: {
        active: active
      }
    }).then(function(e) {
      console.log(e);
      $scope.config = e.data;
    });
  }

  $scope.activate_voting_hardcore = function() {
    $http({
      url: 'vote-config/1/activate-voting-hardcore',
      method: 'PATCH',
      headers: $auth.retrieveData('auth_headers')
    }).then(function(e) {
      console.log(e);
      $scope.config = e.data;
    });
  }

  if(!$rootScope.user.admin){
    $location.path('/');
  }

  $scope.fetch_random();
  $scope.fetch_config();
});