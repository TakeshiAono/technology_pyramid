class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    set_q
    @works = @q.result
  end

  private
  def set_q
    @q = Work.ransack(params[:q])
  end

end
