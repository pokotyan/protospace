class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit,:update]

  def index
  end

  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes.page(params[:page])
  end

  def edit
  end

  def update
    current_user.update(update_params)
    sign_in(current_user, bypass: true)
    redirect_to root_path,notice: 'プロフィールの編集が完了しました'
  end

  private

  def update_params
    params.require(:user).permit(:name, :email, :password, :member, :profile, :works, :avatar)
  end

end
