class MyPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: %i[index]

  def index
    @my_pages = User.all
    @users = User.all
    @favorites = Favorite.all
  end

  private

  def set_q
    @q = Work.ransack(params[:q])
  end
end
