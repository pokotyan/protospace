class PrototypesController < ApplicationController

  def index
  end

  def show
  end

  def new
    @prototype = Prototype.new
    @prototype.images.build
  end

  def create
    Prototype.create(create_params)
    redirect_to root_path
  end

  private
    def create_params
      params.require(:prototype).permit(
        :title,
        :catch_copy,
        :concept,
        images_attributes: [:image,:status]
      ).merge(user_id: current_user.id)
    end

end
