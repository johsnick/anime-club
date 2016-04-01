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

  if(!$rootScope.user.admin){
    $location.path('/');
  }

  $scope.fetch_random();
});