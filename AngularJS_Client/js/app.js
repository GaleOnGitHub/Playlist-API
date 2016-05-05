(function(){

    var app = angular.module('myApp',[
        'ngRoute',
        'ngResource',
        'myControllers'
    ]);



    app.config(['$routeProvider','$locationProvider',
    function($routeProvider, $locationProvider){
        //$locationProvider.html5Mode(true).hashPrefix('!');

        $routeProvider.
            when('/playlists', {
                templateUrl: 'partials/playlists.html',
                controller: 'PlaylistController'
            })
            .when('/tracks', {
                templateUrl: 'partials/tracks.html',
                controller: 'TracksController'
            })
            .otherwise({
                redirectTo: '/AngularJS_Client'
            });
    }]);

})();