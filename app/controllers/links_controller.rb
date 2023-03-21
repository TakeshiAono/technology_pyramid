class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, :set_work, :set_technology, only: %i[show edit update destroy]

  def index
    # session[:technology_id] = params[:format]
    @technology = Technology.find(params[:technology_id])
    @work = Work.find(params[:work_id])
    @owner = Technology.find(params[:technology_id]).work.user
    @links = Link.where(technology_id: @technology.id)
  end

  def show; end

  def new
    set_work
    set_technology
    @link = Link.new(technology_id: @technology.id)
  end

  def edit; end

  def create
    set_work
    set_technology
    @link = Link.new(link_params)
    respond_to do |format|
      if @link.save
        format.html { redirect_to work_technology_link_path(@work, @technology, @link), notice: 'Link' + I18n.t('notice.success.created') }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to work_technology_links_path(@work, @technology), notice: 'Link' + I18n.t('notice.success.updated') }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_work
    set_technology
    @link.destroy
    respond_to do |format|
      format.html do
        redirect_to work_technology_links_path(@work, @technology), notice: 'Link' + I18n.t('notice.success.destroyed')
      end
      format.json { head :no_content }
    end
  end

  def good_register
    set_work
    set_technology
    if LinkGood.find_by(user_id: current_user.id, link_id: params[:id])
      redirect_to work_technology_links_path(params[:technology_id])
    else
      LinkGood.create(user_id: current_user.id, link_id: params[:id])
      link = Link.find(params[:id])
      link.update(good_counter: link.link_goods.count)
      good_counter = link[:good_counter]
      redirect_to work_technology_links_path(@work, @technology)
    end
  end

  def good_unregister
    set_work
    set_technology
    if LinkGood.find_by(user_id: current_user.id, link_id: params[:id])
      LinkGood.find_by(user_id: current_user.id, link_id: params[:id]).destroy
      link = Link.find(params[:id])
      link.update(good_counter: link.link_goods.count)
      good_counter = link[:good_counter]
      redirect_to work_technology_links_path(@work, @technology)
    else
      redirect_to work_technology_links_path(@work, @technology)
    end
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end

  def set_work
    @work = Work.find(params[:work_id])
  end

  def set_technology
    @technology = Technology.find(params[:technology_id])
  end

  def link_params
    params.require(:link).permit(:title, :url, :good_counter, :technology_id)
  end
end
