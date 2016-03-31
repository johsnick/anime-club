var anime = angular.module('anime');
anime.controller('ShowController', function ($scope, $http, $auth, $rootScope, $route){
  $scope.shows = [];

  $scope.mylist_search = function (){
    $scope.shows = null;
    $scope.loading = true;
    $http({
      url: '/animelist/search',
      method: 'GET',
      params: {query: $scope.query},
      headers: $auth.retrieveData('auth_headers'),
    }).then(function (e) {
        $scope.loading = false;
        $scope.shows = e.data;
    });
  }

  $scope.add_show = function (show){

    $http({
      url: '/shows',
      method: 'POST',
      headers: $auth.retrieveData('auth_headers'),
      params: {
        animelist_id: show.id,
        description: show.synopsis,
        name: show.title,
        photo: show.image
      }
    }).then(function (e) {
      show.id = e.data.id ;
      show.vote_count = 0;
      show.animelist_id = e.data.animelist_id;
      show.photo = e.data.photo;
      show.description = e.data.description;
      show.name = e.data.name;
    });
  }

  $scope.vote = function(show, vote_type){
    $http({
      url: '/votes',
      method: 'POST',
      headers: $auth.retrieveData('auth_headers'),
      params: {show_id: show.id, vote_type: vote_type}
    }).then(function (e){
      show.voted = true;
      show.error = null;
      show.vote_count = show.vote_count + e.data.value;
    }).catch(function (e){
      show.error = e.data.votes[0];
    })
  }

  $scope.unvote = function(show){
    $http({
      url: '/votes/unvote',
      method: 'DELETE',
      headers: $auth.retrieveData('auth_headers'),
      params: {show_id: show.id}
    }).then(function (e){
      show.voted = false;
      show.error = null;
      show.vote_count = show.vote_count - e.data.value;
    });
  }

  $scope.load_shows = function (){
    $scope.shows = null;
    $scope.loading = true;
    $http({
      url: '/shows/votes-page',
      method: 'GET',
      headers: $auth.retrieveData('auth_headers'),
    }).then( function (e) {
      $scope.loading = false;
      $scope.shows = e.data;
    });
  }

  $scope.this_week = function (){
    $scope.shows = null;
    $scope.loading = true;
    $http({
      url: '/shows/this-week',
      method: 'GET',
      headers: $auth.retrieveData('auth_headers')
    }).then(function (e){
      $scope.loading = false;
      $scope.shows = e.data;
    });
  }

  $scope.my_votes = function (){
    $scope.shows = null;
    $scope.loading = true;
    $http({
      url: '/votes/my-votes',
      method: 'GET',
      headers: $auth.retrieveData('auth_headers')
    }).then(function (e){
      $scope.loading = false;
      $scope.shows = e.data;
    });
  }

  if($route.current.$$route.view == 'my-votes'){
    $scope.my_votes();
  } else if($route.current.$$route.view == 'this-week'){
    $scope.this_week();
  } else {
    $scope.load_shows();
  }
});