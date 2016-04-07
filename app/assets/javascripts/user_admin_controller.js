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

  $scope.reset_all_votes = function() {
    $http({
      url: 'votes/reset',
      method: 'DELETE',
      headers: $auth.retrieveData('auth_headers')
    }).then(function (e){
      console.log('done');
    });
  }

  $scope.update_config = function (){
    $http({
      url: 'vote-config/1',
      method: 'PATCH',
      headers: $auth.retrieveData('auth_headers'),
      params: {
        stop_voting_time: $scope.stop_voting_time,
        stop_voting_day: $scope.stop_voting_day,
        timezone: $scope.timezone
      }
    }).then(function (e) {
      console.log(e)
      $scope.error = false;
    }, function (e) {
      $scope.error = "Invalid Configuration"
    });
  }

  if(!$rootScope.user.admin){
    $location.path('/');
  }

  $scope.fetch_random();
});