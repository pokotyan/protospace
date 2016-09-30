module ApplicationHelper

  def prototype_index_active?(controller_name)
    if controller_name == "popular"
      true
    else controller_name == "newest"
      false
    end
  end

end
