class TagsController < ApplicationController

  def index
   @web_design_tags_count = Prototype.tags_on(:web_designs).count
   @application_tags_count = Prototype.tags_on(:applications).count
   @uis_tags_count = Prototype.tags_on(:uis).count
  end

  def show
  end

end
