class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    set_q
    @works = @q.result
  end

  def create
    set_q
    @works = @q.result
    Favorite.create(user_id: current_user.id, favorite_id: params[:user_id])
    byebug
    render :index
  end

  private
  def set_q
    @q = Work.ransack(params[:q])
  end

end
