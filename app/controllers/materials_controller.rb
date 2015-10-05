class MaterialsController < ApplicationController
  before_action :set_material

  # GET /materials
  # GET /materials.json
  # def index
  #   @materials = Material.all
  # end

  # GET /materials/1
  # GET /materials/1.json
  def show
  end

  # GET /materials/new
  def new
    @material = Material.new song: @song
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials
  # POST /materials.json
  def create
    @material = @song.materials.build(material_params)

    respond_to do |format|
      if @material.save
        format.html { redirect_to playlist_song_path(@playlist, @song), notice: 'Material was successfully created.' }
        format.json { render :show, status: :created, location: @material.song }
      else
        format.html { render :new }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to playlist_song_path(@playlist, @song), notice: 'Material was successfully updated.' }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material.destroy
    respond_to do |format|
      format.html { redirect_to playlist_song_path(@playlist, @song), notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @playlist = Playlist.find(params[:playlist_id])
      @material = Material.find(params[:id]) if params[:id]
      @song = Song.find(params[:song_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:song_id, :title, :url, :type)
    end
end
