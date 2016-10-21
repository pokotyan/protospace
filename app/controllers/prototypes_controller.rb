class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @prototypes = Prototype.includes(:images).page(params[:page]).order("created_at DESC")
  end

  def show
    @main_image = @prototype.images.main
    @sub_images = @prototype.images.sub

    @comment = Comment.new
  end

  def new
    @prototype = Prototype.new
    @prototype.images.build
  end

  def create
    @prototype = current_user.prototypes.build(create_params)
    if @prototype.save
      redirect_to root_path, notice: "プロトタイプの投稿が完了しました"
    else
      flash.now[:alert] = "プロトタイプの投稿に失敗しました"
      render :new
    end
  end

  def edit
    @main_image = @prototype.images.main
    @sub_images = @prototype.images.sub
  end

  def update
    #binding.pry
    if @prototype.update(update_params)
      redirect_to prototype_path(@prototype), notice: "プロトタイプの更新が完了しました"
    else
      redirect_to edit_prototype_path(@prototype), alert: "プロトタイプの更新に失敗しました"
    end
  end

  def destroy
    if @prototype.destroy
      redirect_to root_path, notice: "プロトタイプの削除が完了しました"
    else
      redirect_to root_path, alert: "プロトタイプの削除に失敗しました"
    end
  end

  private
    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    def create_params
      params.require(:prototype).permit(
        :title,
        :catch_copy,
        :concept,
        images_attributes: [:image,:status],
        tag_list: []
      )
    end

    def update_params
      params.require(:prototype).permit(
        :title,
        :catch_copy,
        :concept,
        images_attributes: [:id,:image,:status], #idも受け取るようにしないとUnpermitted parameter:id
        tag_list: []
      )#.merge(tag_list: params[:prototype][:tag_list])
    end

end
