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
    @prototype = Prototype.new(create_params)
    if @prototype.save
      redirect_to root_path, notice: "プトロタイプの投稿が完了しました"
    else
      flash.now[:alert] = "プロトタイプの投稿に失敗しました"
      render :new
    end
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
