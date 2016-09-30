class Prototypes::NewestController < ApplicationController

  def index
    @prototypes = Prototype.includes(:images).page(params[:page]).order("updated_at DESC")
    render "prototypes/index"
  end

end
