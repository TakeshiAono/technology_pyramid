class WorksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work, only: %i[show edit update destroy]

  def index
      @active_works = current_user.works.where(active_flag: true)
      @inactive_works = current_user.works.where(active_flag: false)
  end

  def show
  end

  def new
    @work = Work.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params)
    respond_to do |format|
      if @work.save
        format.html { redirect_to work_url(@work), notice: "Work" + I18n.t("notice.success.created") }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to work_url(@work), notice: "Work" + I18n.t("notice.success.updated") }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: "Work" + I18n.t("notice.success.destroyed") }
      format.json { head :no_content }
    end
  end

  private
    def set_work
      @work = Work.find(params[:id])
    end

    def work_params
      params.require(:work).permit(:title, :public_flag, :user_id, :active_flag)
    end
end
