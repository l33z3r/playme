class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy, :index, :new, :create]

  # GET /songs
  # GET /songs.json
  def index
    @songs = @playlist.songs.order(:name)
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @materials = @song.materials.where('user_id != ?', current_user.id)
    @my_materials = current_user.materials.where('song_id = ?', @song)

    # Get related artitsts
    @spotify_track = RSpotify::Track.find(@song.spotify_track_id)
    @related_artists = @spotify_track.artists.first.related_artists

    @related_songs = @related_artists.shuffle[0..4].map do |artist|
      artist.top_tracks('IE').shuffle.first
    end.flatten
    @suggested_material = @song.youtube_material
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    if song_params[:spotify_track_id]
      spotify_track = RSpotify::Track.find(song_params[:spotify_track_id])
      @song = Song.find_or_create_by spotify_track_id: song_params[:spotify_track_id],
                                     artist: Artist.find_or_create_by(name: spotify_track.artists.first.name),
                                     name: spotify_track.name, spotify_url: spotify_track.uri
    end
    @song = Song.new(song_params) if @song.nil?

    PlaylistsSongs.find_or_create_by song: @song, playlist: @playlist

    respond_to do |format|
      if @song.save
        format.html { redirect_to playlist_song_path(@playlist, @song), notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sync_spotify
    # if @spotify_user
    #   @playlist = @spotify_user.playlists.select { |playlist| playlist.name == '<3' }.first
    #
    #   if !@playlist
    #     @playlist = @spotify_user.playlists.third
    #   end
    #
    #   @playlist.tracks.each do |track|
    #
    #     artist = Artist.find_or_create_by name: track.artists.first.name
    #
    #     song = Song.find_or_initialize_by spotify_track_id: track.id, spotify_url: track.uri, name: track.name, artist: artist
    #
    #     binding.pry
    #
    #     if song.new_record?
    #       song.save!
    #       SongsWorker.perform_async(song.id, current_user.id)
    #     end
    #
    #     SongsUsers.find_or_create_by user: current_user, song: song
    #
    #   end
    #
    #   redirect_to songs_url, notice: 'Successfully synced with Spotify.'
    # else
    #   redirect_to songs_url, error: 'Spotify user not found.'
    # end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @playlist = Playlist.find params[:playlist_id]
      @song = Song.find(params[:id]) if params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params[:song]
    end
end
