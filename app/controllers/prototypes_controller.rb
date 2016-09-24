class PrototypesController < ApplicationController

  def index
    @prototypes = Prototype.all
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
      redirect_to root_path, notice: "プロトタイプの投稿が完了しました"
    else
      flash.now[:alert] = "プロトタイプの投稿に失敗しました"
      render :new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    @main_image = @prototype.images.main
    @sub_images = @prototype.images.sub
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(update_params)
      redirect_to root_path, notice: "プロトタイプの更新が完了しました"
    else
      flash.now[:alert] = "プロトタイプの更新に失敗しました"
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path, notice: "プロトタイプの削除が完了しました"
    else
      redirect_to root_path, alert: "プロトタイプの削除に失敗しました"
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

    def update_params
      params.require(:prototype).permit(
        :title,
        :catch_copy,
        :concept,
        images_attributes: [:id,:image,:status] #idも受け取るようにしないとUnpermitted parameter:id
      )
    end

end
