angular.module('anime').
controller('MainController', function ($scope, $auth, $rootScope, $location){
  $rootScope.view = 'sign_in';

  $rootScope.$on('auth:validation-success', function (e, data) {
        $rootScope.user = data;
        $location.path('/shows');
  });

  $rootScope.$on('auth:validation-failure', function (e, data){
    $rootScope.user = null;
    $location.path('/');
  });

  console.log($rootScope.user);

  if(! $rootScope.user.id){
    $location.path('/');
  }

  $scope.sign_out = function (){
    $auth.signOut()
    .then(function (e) {
      $rootScope.user = null;
      $location.path('/');
    });
  }

});
