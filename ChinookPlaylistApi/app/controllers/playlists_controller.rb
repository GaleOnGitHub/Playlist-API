include ActionController::HttpAuthentication::Token::ControllerMethods

class PlaylistsController < ApplicationController
  before_filter :restrict_access
  #respond_to :json
  before_action :set_client
  before_action :set_playlist, only: [:show, :update, :destroy]


  # GET /playlists
  # GET /playlists.json
  def index
    #@playlist = Playlist.all
    @playlist = @client.playlist
    render :json => @playlist.to_json(:except => :ApiKey_id,:include => {:track => { :only => [:TrackId, :Name, :UnitPrice] }})
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    render :json => @playlist.to_json(:include => {:track => { :only => [:TrackId, :Name, :UnitPrice] }})
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.ApiKey_id = @client.id
    if @playlist.save
      @playlist.sync_tracks(playlist_tracks_params)
      #render json: @playlist, status: :created, location: @playlist
      render json: {status: 200, message: "Created successfully"}
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    if @playlist.update(playlist_params)
      @playlist.sync_tracks(playlist_tracks_params)
      #render json: @playlist, status: :ok, location: @playlist
      render json: {status: 200, message: "Update successful"}
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.playlist_track.delete_all
    @playlist.destroy

    render json: {status: 200, message: "Deleted successfully"}
  end

  private

    def set_playlist
      @playlist = @client.playlist.find(params[:id])
    end

    def set_client
      authenticate_or_request_with_http_token do |token, options|
        @client = ApiKey.where(access_token: token).first
      end
    end

    def playlist_params
      #params.require(:playlist).permit(:PlaylistId, :Name)
      params.permit(:PlaylistId, :Name)
    end

    def playlist_tracks_params
      params.permit(:Tracks)
    end

    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(access_token: token)
      end
    end

end
