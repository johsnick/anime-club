angular.module('anime')
.controller('UserController', function ($scope, $auth, $rootScope, $location, $timeout){
  $scope.sign_up = function (){
    $auth.submitRegistration({email: $scope.username + '@blah.com',
                             password: $scope.password,
                             password_confirmation: $scope.password_confirmation})
    .then(function (e) {
      console.log(e);
      $scope.new_user = true;
      $scope.username = null;
      $scope.password = null;
      $scope.password_confirmation = null;
      $timeout(function (){
        $scope.new_user = false;
      }, 2500);
    }, function (e){
      $scope.error = true;
      $timeout(function (){
        $scope.error = false;
      }, 2500);
    });
  }

  $scope.sign_in = function (){
    $auth.submitLogin({email: $scope.username + '@blah.com', password: $scope.password})
    .then( function (e){
      console.log(e);
      $rootScope.user = e;
      $location.path('/shows');
    }).catch( function (e){
      console.log(e);
      $scope.error = e.errors[0];
    });
  }

  $scope.sign_out = function (){
    $auth.signOut()
    .then(function (e){
      $rootScoop.user = null;
    }, function (e){
      console.log(e);
    });
  }

  $rootScope.$on('sign_out', function (e){
    $scope.sign_out();
  });

  $rootScope.$on('auth:validation-success', function (e, data) {
    if($location.path == '/'){
      $rootScope.user = data;
      $location.path('/shows');
    }
  });
});