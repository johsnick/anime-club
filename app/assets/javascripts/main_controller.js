angular.module('anime').
controller('MainController', function ($scope, $auth, $rootScope){
  $rootScope.view = 'sign_in';

  $rootScope.$on('auth:validation-success', function (e, data) {
    $rootScope.user = data;
    console.log('sent');
    $rootScope.$broadcast('signed_in');
  });

  $scope.this_week = function (){
    $rootScope.$broadcast('this-week');
  }

  $scope.my_votes = function (){
    $rootScope.$broadcast('my-votes');
  }

  $scope.top_shows = function (){
    $rootScope.$broadcast('top-shows');
  }

  $scope.sign_out = function (){
    $rootScope.$broadcast('sign_out');
  }
});
