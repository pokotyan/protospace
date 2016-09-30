module ApplicationHelper

  def prototype_index_active?(controller_name)
    if controller_name == controller.controller_name
      true
    end
  end

end
