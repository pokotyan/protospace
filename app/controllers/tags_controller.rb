class TagsController < ApplicationController

  def index
   @web_design_tags_count = Prototype.tags_on(:web_designs).pluck(:taggings_count).inject(:+)
   @application_tags_count = Prototype.tags_on(:applications).pluck(:taggings_count).inject(:+)
   @uis_tags_count = Prototype.tags_on(:uis).pluck(:taggings_count).inject(:+)
  end

  def show
  end

end
