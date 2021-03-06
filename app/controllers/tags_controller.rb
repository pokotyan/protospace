class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @tag_name = ActsAsTaggableOn::Tag.find(params[:id]).name
    @prototypes = Prototype.tagged_with(@tag_name)
  end

end
