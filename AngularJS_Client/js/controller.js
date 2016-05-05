(function(){
'use strict';

    var myControllers = angular.module('myControllers',[]);

    myControllers.config(function($httpProvider){
        $httpProvider.defaults.headers.common['Authorization'] = 'Token token="3529c88ad211f42edd918fe07bec349d"';

    });

    myControllers.factory("Playlist", function($resource) {
        //return $resource("http://localhost:3000/actors/:actor_id");
        return $resource("http://localhost:3000/api/playlists/:PlaylistId", null,{
            'update': { method: 'PUT' }
        });
    });

    myControllers.factory("Track", function($resource) {
        //return $resource("http://localhost:3000/actors/:actor_id");
        return $resource("http://localhost:3000/api/tracks/:TrackId", null,{
            'update': { method: 'PUT' }
        });
    });

    myControllers.controller('PlaylistController', ['$scope', '$http','Playlist','Track',
        function($scope, $http, Playlist, Track) {
            var selectedIndex = null;

            $scope.refreshReport = function(){
                Playlist.query(function(data) {
                    $scope.playlists = data;
                });
            };

            $scope.refreshReport();

            $scope.retrievePlaylist = function(pid, index){
                Playlist.get({ PlaylistId: pid }, function(data) {
                    $scope.getTracks();
                    $scope.form_name = "Playlist";
                    $scope.selectedPlaylist = data;
                    $scope.formType = "Edit";
                    selectedIndex = index;
                });
            };

            $scope.updatePlaylist = function(pid){
                var playlist = Playlist.get({PlaylistId: pid}, function(data){
                    var newName = $scope.selectedPlaylist.Name;
                    var newTracks = convertTracksToTrackIds($scope.selectedPlaylist.track);

                    data = {Name: newName, Tracks: JSON.stringify(newTracks)};
                    $scope.message = Playlist.update({PlaylistId:pid}, data);
                    $scope.refreshReport();
                });
            };

            $scope.addPlaylist = function(){
                var data = {
                    Name: $scope.selectedPlaylist.Name,
                    Tracks: JSON.stringify(convertTracksToTrackIds($scope.selectedPlaylist.track))
                };
                $scope.message = Playlist.save(data);
                $scope.refreshReport();
            };

            $scope.deletePlaylist = function(pid){
                $scope.message = Playlist.delete({ PlaylistId: pid });
                $scope.selectedPlaylist = null;
                $scope.playlists.splice(selectedIndex,1);
                $scope.refreshReport();

            };

            $scope.newPlaylist = function(){
                $scope.selectedPlaylist = {Name:'',track:[]};
                $scope.formType = "Create";
                $scope.getTracks();
            };
            $scope.addTrack = function(index){
                var newTrack = $scope.trackList[index];
                function checkIfPresent(arr, val){
                    return arr.some(function(arrVal){
                        return val.TrackId === arrVal.TrackId;
                    });
                }
                //only add track if it doesn't exist in playlist
                if(!checkIfPresent($scope.selectedPlaylist.track,newTrack)){
                    $scope.selectedPlaylist.track.push(newTrack);
                }else{
                    $scope.message = {status: 'warning',message: "Track already exists in playlist."}
                }
            };
            $scope.removeTrack = function(index){
                $scope.selectedPlaylist.track.splice(index,1);
            };

            $scope.getTracks = function(){
               Track.query(function(data){
                   $scope.trackList = data;
               });
            };

            function convertTracksToTrackIds(trackArray){
                var tracks = [];
                trackArray.forEach(function(track, index){
                    tracks.push({TrackId:track.TrackId});
                });
                return tracks;
            }
    }]);

    myControllers.controller('TracksController', ['$scope', '$http','Track',
        function($scope, $http, Track) {
            $scope.getTracks = function(){
                Track.query(function(data){
                    $scope.tracks = data;
                });
            };
            $scope.getTracks();
        }]);
})();