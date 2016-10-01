class TagsController < ApplicationController
  before_action :set_tags

  def index
  end

  def show
   @web_design_prototypes = @web_design_tags.map{ |name| Prototype.tagged_with(name) }.flatten
   @application_prototypes = @application_tags.map{ |name| Prototype.tagged_with(name) }.flatten
   @ui_prototypes = @uis_tags.map{ |name| Prototype.tagged_with(name) }.flatten
  end

  private

  def set_tags
   @web_design_tags = Prototype.tags_on(:web_designs)
   @application_tags = Prototype.tags_on(:applications)
   @uis_tags = Prototype.tags_on(:uis)
  end

end
