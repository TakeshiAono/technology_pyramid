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
    render :index
    # session[:q] = Work.ransack(params[:q])
    # redirect_to searches_index_path
  end

  def destroy
    set_q
    @works = @q.result
    Favorite.where(user_id: current_user.id, favorite_id: params[:user_id]).first.destroy
    render :index
    # session[:q] = Work.ransack(params[:q])
    # redirect_to searches_index_path
  end

  private
  def set_q
    @q = Work.ransack(params[:q])
  end

end
