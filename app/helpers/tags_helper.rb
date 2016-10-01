module TagsHelper

  def get_prototype_of_context(context_name)
    tags = Prototype.tags_on(context_name)
    tags.map{ |name| Prototype.tagged_with(name) }.flatten
  end

  def get_prototype_of_tag(tag_name)
    Prototype.tagged_with(tag_name)
  end

end
