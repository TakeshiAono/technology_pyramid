class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q
  before_action :set_work
  
  def index
    if @q.conditions.present?
      session[:search_word] = @q.conditions[0].value
      flash.now[:alert] = "検索キーワードに合致しませんでした" if @q.result.first == nil
    else
      @works = nil
      flash.now[:alert] = "検索キーワードを入力してください"
    end
  end

  def favorite_registe
    Favorite.create(user_id: current_user.id, favorite_id: params[:user_id])
    flash.now[:notice] = I18n.t('favorites.register_notice')
    render :index
  end

  def show
    render :index
  end

  def favorite_unregiste
    Favorite.where(user_id: current_user.id, favorite_id: params[:user_id]).first.destroy
    flash.now[:alert] = I18n.t('favorites.unregister_notice')
    render :index
  end

  private
  def set_q
    @q = Work.ransack(params[:q])
  end

  def set_work
    @works = @q.result
  end
end
