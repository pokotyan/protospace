class Prototypes::PopularController < ApplicationController

  def index
    @prototypes = Prototype.includes(:images).page(params[:page]).order("likes_count DESC")
    render "prototypes/index"
  end

end
