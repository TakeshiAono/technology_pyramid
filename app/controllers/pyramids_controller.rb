class PyramidsController < ApplicationController

  def index
      session[:top_technology_id] = params[:format] if params[:format].present?
      @top_technology = Technology.find(session[:top_technology_id])

      @top_hierarckies = []
      @first_hierarckies = []
      @second_hierarckies = []
      @third_hierarckies = []
      @fourth_hierarckies = []
      @hierarckies = []

      @top_technology.lower_technologies.each do |technology|
        @first_hierarckies << technology
      end
      
      @first_hierarckies.each do |technology|
        technology.lower_technologies.each do |technology2|
          @second_hierarckies << technology2
        end
      end

      @second_hierarckies.each do |technology|
        technology.lower_technologies.each do |technology2|
          @third_hierarckies << technology2
        end
      end

      @third_hierarckies.each do |technology|
        technology.lower_technologies.each do |technology2|
          @fourth_hierarckies << technology2
        end
      end
  end
end
