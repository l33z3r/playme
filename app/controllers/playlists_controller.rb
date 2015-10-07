class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all
  end

  def select_spotify
    @spotify_playlists = get_user_spotify_playlists
    @currently_synced_playlists = current_user.playlists.map { |p| p.spotify_id }
  end

  def sync_spotify
    @spotify_playlists = get_user_spotify_playlists
    @selected_playlists = @spotify_playlists.select { |p| params[:playlists].member?(p.id) }

    @selected_playlists.each do |spotify_playlist|
      playlist = Playlist.find_or_create_by spotify_id: spotify_playlist.id, name: spotify_playlist.name
      PlaylistsUsers.find_or_create_by playlist: playlist, user: current_user

      spotify_playlist.tracks.each do |track|

        artist = Artist.find_or_create_by name: track.artists.first.name

        song = Song.find_or_initialize_by spotify_track_id: track.id,
                                          spotify_url: track.uri, name: track.name, artist: artist,
                                          album_artwork_url: track.album.images[1]['url']

        if song.new_record?
          song.save!
          SongsWorker.perform_async(song.id, current_user.id)
        end

        PlaylistsSongs.find_or_create_by playlist: playlist, song: song
      end
    end
    redirect_to playlists_url
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_user_spotify_playlists
    spotify_playlists = @spotify_user.playlists(limit: 50, offset: 0)

    if spotify_playlists.length == 50
      #get another batch so we support up to 100 playlists
      more_spotify_playlists = @spotify_user.playlists(limit: 50, offset: 50)
      spotify_playlists = spotify_playlists.concat more_spotify_playlists
    end

    spotify_playlists
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:name)
    end
end
