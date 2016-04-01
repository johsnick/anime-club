angular.module('anime').
controller('MainController', function ($scope, $auth, $rootScope, $location){
  $rootScope.$on('auth:validation-failure', function (e, data){
    $rootScope.user = null;
    $location.path('/');
  });

  $scope.sign_out = function (){
    $auth.signOut()
    .then(function (e) {
      $rootScope.user = null;
      $location.path('/');
    });
  }

});
