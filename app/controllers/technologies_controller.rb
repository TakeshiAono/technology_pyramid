class TechnologiesController < ApplicationController
  before_action :set_technology, only: %i[ show edit update destroy ]

  # GET /technologies or /technologies.json
  def index
    path = Rails.application.routes.recognize_path(request.referer)
    session[:before_controller_path] = path[:controller]
    if params[:format].present?
      session[:work_id] = params[:format]
    end
    work = Work.find(session[:work_id])
    @technologies = work.technologies.where(basic_flag: false)
    @basic_technologies = work.technologies.where(basic_flag: true)
  end

  # GET /technologies/1 or /technologies/1.json
  def show
    path = Rails.application.routes.recognize_path(request.referer)
    session[:before_controller_path] = path[:controller]
  end

  # GET /technologies/new
  def new
    path = Rails.application.routes.recognize_path(request.referer)
    session[:before_controller_path] = path[:controller]
    if session[:before_controller_path] == "pyramids"
      session[:top_technology_id] = params[:format]
    end
    @technology = Technology.new(work_id: session[:work_id])
  end

  # GET /technologies/1/edit
  def edit
    path = Rails.application.routes.recognize_path(request.referer)
    session[:before_controller_path] = path[:controller]
  end

  # POST /technologies or /technologies.json
  def create
    @technology = Technology.new(technology_params)
    respond_to do |format|
      if @technology.save
        format.html { redirect_to technology_url(@technology), notice: "Technology was successfully created." }
        format.json { render :show, status: :created, location: @technology }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @technology.errors, status: :unprocessable_entity }
      end
    end
    Hierarcky.create(technology_id: session[:top_technology_id],lower_technology_id: @technology.id)
  end

  # PATCH/PUT /technologies/1 or /technologies/1.json
  def update
    respond_to do |format|
      if @technology.update(technology_params)
        format.html { redirect_to technology_url(@technology), notice: "Technology was successfully updated." }
        format.json { render :show, status: :ok, location: @technology }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @technology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /technologies/1 or /technologies/1.json
  def destroy
    @technology.destroy

    respond_to do |format|
      format.html { redirect_to technologies_url, notice: "Technology was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_technology
      @technology = Technology.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def technology_params
      params.require(:technology).permit(:name, :public_flag, :upper_technology, :lower_technology, :work_id, :basic_flag)
    end
end
