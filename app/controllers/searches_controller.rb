class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    set_q
    @works = @q.result
    if @q.conditions[0].present?
      session[:search_word] = @q.conditions[0].values[0].value
    end
  end

  def create
    Favorite.create(user_id: current_user.id, favorite_id: params[:format])
    @q = Work.ransack(title_cont: session[:search_word])
    @works = @q.result
    render :index
  end

  def destroy
    Favorite.where(user_id: current_user.id, favorite_id: params[:id]).first.destroy
    @q = Work.ransack(title_cont: session[:search_word])
    @works = @q.result
    render :index
  end

  private
  def set_q
      @q = Work.ransack(params[:q])
  end

end
