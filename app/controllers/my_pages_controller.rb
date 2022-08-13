class MyPagesController < ApplicationController
  before_action :set_my_page, only: %i[ show edit update destroy ]
  before_action :set_q, only: [:index, :search]

  # GET /my_pages or /my_pages.json
  def index
    # if current_user.sign_in_count.zero?
      # redirect_to top_my_pages_path
    # end
    @my_pages = User.all
    @users = User.all
  end

  # GET /my_pages/1 or /my_pages/1.json
  def show
  end

  # GET /my_pages/new
  def new
    @my_page = User.new
  end

  # GET /my_pages/1/edit
  def edit
  end

  # POST /my_pages or /my_pages.json
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

  # PATCH/PUT /my_pages/1 or /my_pages/1.json
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

  # DELETE /my_pages/1 or /my_pages/1.json
  def destroy
    @my_page.destroy

    respond_to do |format|
      format.html { redirect_to my_pages_url, notice: "My page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def top
    # render top_my_pages_path
    # current_user.update(sign_in_count: current_user.sign_in_count + 1)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_q
      @q = Work.ransack(params[:q])
    end

    def set_my_page
      @my_page = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def my_page_params
      params.fetch(:my_page, {})
    end
end
