class LikesController < ApplicationController

  def like
    prototype = Prototype.find(params[:prototype_id])
    like = current_user.likes.build(prototype_id:prototype.id)
    like.save
    redirect_to :back
  end

  def unlike
    like = Like.find_by(user_id:current_user)
    like.destroy
    redirect_to :back
  end
end
