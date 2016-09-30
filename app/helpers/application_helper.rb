module ApplicationHelper

  def popular_index_active?(controller_name)
    if controller.controller_name == "popular"
      "active"
    end
  end

  def newest_index_active?(controller_name)
    if controller.controller_name == "newest"
      "active"
    end
  end

end
