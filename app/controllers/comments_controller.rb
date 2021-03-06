class CommentsController < ApplicationController

  def create
    comment = current_user.comments.build(create_params)
    comment.save
    @prototype = comment.prototype
  end

  private

  def create_params
    params.require(:comment).permit(:content,:prototype_id)
  end

end
