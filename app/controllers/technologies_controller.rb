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

  def api_create
    technology = Technology.new(
      name: api_technology_params[:name],
      work_id: params[:work_id]
    )

    tech_pos_result = nil
    ActiveRecord::Base.transaction do
      technology.save!

      tech_pos_result = TechnologyPosition.create!(
        top_technology_id: api_technology_params[:top_technology_id].to_i,
        target_technology_id: technology.id,
        x_pos: api_technology_params[:x_pos].to_i,
        y_pos: api_technology_params[:y_pos].to_i
      )

      Hierarcky.create!(
        technology_id:       api_technology_params[:upper_technology_id],
        lower_technology_id: technology.id
      )
    end

    render json: { ok: true, technology_id: technology.id, tech_pos_id: tech_pos_result.id }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { ok: false, error: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  def api_update_all_diff
    ActiveRecord::Base.transaction do
      technology_params_list.each do |tp|

        techonology = Technology.find(tp[:current_tech_id])
        techonology.update!(
          name: tp[:current_tech_name],
          description: tp[:description],
        )

        pos = TechnologyPosition.find(tp[:tech_pos_id])
        pos.update!(
          x_pos: tp[:x_pos],
          y_pos: tp[:y_pos]
        )
      end
    end

    head :ok
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error e
    head :internal_server_error
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
      hierarckies_attributes: %i[id lower_technology_id technology_id]
    )
  end

  def technology_params_list
    params.require(:technologies).map { |p| p.permit(
      :top_technology_id,
      :current_tech_id,
      :current_tech_name,
      :description,
      :x_pos,
      :y_pos,
      :tech_pos_id,
    )}
  end

  def api_technology_params
    params.require(:technology).permit(
      :name,
      :upper_technology_id,
      :description,
      :x_pos,
      :y_pos,
      :top_technology_id,
    )
  end

  def work_params
    params.require(:work_id)
  end
end
