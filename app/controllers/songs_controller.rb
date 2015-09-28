class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @songs = current_user.songs.where('songsterr_url IS NOT NULL').order(:name)
    @songs_without_links = current_user.songs.where('songsterr_url IS NULL').order(:name)
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
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
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
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
    if !@spotify_user.nil?
      @playlist = @spotify_user.playlists.select { |playlist| playlist.name == '<3' }.first

      if !@playlist
        @playlist = @spotify_user.playlists.first
      end

      @playlist.tracks.each do |track|

        artist = Artist.find_or_create_by name: track.artists.first.name

        song = Song.find_or_create_by spotify_track_id: track.id, spotify_url: track.uri, name: track.name, artist: artist
        SongsUsers.find_or_create_by user: current_user, song: song

      end
    end
    redirect_to songs_url, notice: 'Successfully synced with Spotify.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params[:song]
    end
end
