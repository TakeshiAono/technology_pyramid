class MyPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_my_page, only: %i[ show edit update destroy ]
  before_action :set_q, only: [:index, :search]

  def index
    @my_pages = User.all
    @users = User.all
    @favorites = Favorite.all
  end

  def show
  end

  def new
    @my_page = User.new
  end

  def edit
  end

  def create
    @my_page = User.new(my_page_params)

    respond_to do |format|
      if @my_page.save
        format.html { redirect_to my_page_url(@my_page), notice: "My page was successfully created." }
        format.json { render :show, status: :created, location: @my_page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @my_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @my_page.update(my_page_params)
        format.html { redirect_to my_page_url(@my_page), notice: "My page was successfully updated." }
        format.json { render :show, status: :ok, location: @my_page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @my_page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @my_page.destroy

    respond_to do |format|
      format.html { redirect_to my_pages_url, notice: "My page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_q
      @q = Work.ransack(params[:q])
    end

    def set_my_page
      @my_page = User.find(params[:id])
    end

    def my_page_params
      params.fetch(:my_page, {})
    end
end
