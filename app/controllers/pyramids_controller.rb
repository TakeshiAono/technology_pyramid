class PyramidsController < ApplicationController
  before_action :set_pyramid, only: %i[ show edit update destroy ]

  # GET /pyramids or /pyramids.json
  def index
    # if params[:format].present?
      session[:top_technology_id] = params[:format] if params[:format].present?
      @top_technology = Technology.find(session[:top_technology_id])
      # byebug
      # @top_technology.hierarckies.each

      @lower_technologies = @top_technology.hierarckies
      # @technologies = Technology.where(upper_technology: session[:technology_id])
    # else
      # @pyramids = Pyramid.all
    # end
  end

  # GET /pyramids/1 or /pyramids/1.json
  def show
  end

  # GET /pyramids/new
  def new
    @pyramid = Pyramid.new
  end

  # GET /pyramids/1/edit
  def edit
  end

  # POST /pyramids or /pyramids.json
  def create
    @pyramid = Pyramid.new(pyramid_params)

    respond_to do |format|
      if @pyramid.save
        format.html { redirect_to pyramid_url(@pyramid), notice: "Pyramid was successfully created." }
        format.json { render :show, status: :created, location: @pyramid }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pyramid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pyramids/1 or /pyramids/1.json
  def update
    respond_to do |format|
      if @pyramid.update(pyramid_params)
        format.html { redirect_to pyramid_url(@pyramid), notice: "Pyramid was successfully updated." }
        format.json { render :show, status: :ok, location: @pyramid }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pyramid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pyramids/1 or /pyramids/1.json
  def destroy
    # @pyramid.destroy
    hierarcky = Hierarcky.where(technology_id: session[:top_technology_id])
    hierarcky.find_by(lower_technology_id: params[:id]).update(lower_technology_id: nil)

    respond_to do |format|
      format.html { redirect_to pyramids_url, notice: "Pyramid was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pyramid
      # @pyramid = Pyramid.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pyramid_params
      params.require(:pyramid).permit(:name, :public_flag, :technology_id)
    end
end
