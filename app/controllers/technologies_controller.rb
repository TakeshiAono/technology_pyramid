class TechnologiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_technology, only: %i[show edit update destroy]

  def index
    @work = Work.find(params[:work_id])
    # @work = Work.find(id: params[:work_id])
    @technologies = @work.technologies.where(basic_flag: false)
    @basic_technologies = @work.technologies.where(basic_flag: true)
  end

  def show
    @work = Work.find(params[:work_id])
    # path = Rails.application.routes.recognize_path(request.referer)
    # session[:before_controller_path] = path[:controller]
  end

  def new
    @work = Work.find(params[:work_id])
    # path = Rails.application.routes.recognize_path(request.referer)
    # session[:before_controller_path] = path[:controller]
    # session[:top_technology_id] = params[:format] if session[:before_controller_path] == 'pyramids'
    @technology = Technology.new(work_id: session[:work_id])
    @technology.hierarckies.build
  end

  def edit
    @work = Work.find(params[:work_id])
    # path = Rails.application.routes.recognize_path(request.referer)
    # session[:before_controller_path] = path[:controller]
    @technology.hierarckies.build
    @technology.hierarckies.build
  end

  def create
    @work = Work.find(params[:work_id])
    @technology = Technology.new(technology_params)
    @technology.work_id = @work.id
    respond_to do |format|
      if @technology.save
        @upper_hierarcky = Hierarcky.new(
          technology_id: params[:technology][:upper_technology_id],
          lower_technology_id: @technology.id
        )
        @upper_hierarcky.save
        format.html { redirect_to work_technologies_path(@work), notice: 'Technology' + I18n.t('notice.success.created') }
        format.json { render :show, status: :created, location: work_id }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @technology.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @work = Work.find(params[:work_id])
    respond_to do |format|
      if @technology.update(technology_params)
        format.html { redirect_to work_technologies_path(@work), notice: 'Technology' + I18n.t('notice.success.updated') }
        format.json { render :show, status: :ok, location: @technology }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @technology.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @technology.destroy
    respond_to do |format|
      format.html { redirect_to work_technologies_path(params[:work_id]), notice: 'Technology' + I18n.t('notice.success.destroyed') }
      format.json { head :no_content }
    end
  end

  def reset
    Hierarcky.find(params[:hierarcky_id]).destroy
    redirect_to edit_technology_path(params[:technology_id])
  end

  private

  def set_technology
    @technology = Technology.find(params[:id])
  end

  def technology_params
    params.require(:technology).permit(
      :name,
      :public_flag,
      :work_id,
      :basic_flag,
      hierarckies_attributes: %i[id lower_technology_id technology_id])
  end

  def work_params
    params.require(:work_id)
  end
end
