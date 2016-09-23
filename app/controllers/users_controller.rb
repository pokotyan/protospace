class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
  end

  def edit
  end

  def update
    current_user.update(update_params)
    redirect_to root_path,notice: 'プロフィールの編集が完了しました'
  end

  private

  def update_params
    params.require(:user).permit(:name,:email,:member,:profile,:works)
  end

end
