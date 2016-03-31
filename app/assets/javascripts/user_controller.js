angular.module('anime')
.controller('UserController', function ($scope, $auth, $rootScope, $location){
  $scope.sign_up = function (){
    $auth.submitRegistration({email: $scope.username + '@blah.com',
                             password: $scope.password,
                             password_confirmation: $scope.password})
    .then(function (e) {
      console.log(e);
    }).catch(function (e){
      console.log(e);
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
    });
  }

  $scope.sign_out = function (){
    $auth.signOut()
    .then(function (e){
      $rootScoop.user = null;
    }).catch(function (e){
      console.log(e);
    });
  }

  $rootScope.$on('sign_out', function (e){
    $scope.sign_out();
  });
});