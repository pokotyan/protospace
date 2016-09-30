module ApplicationHelper

  def prototype_index_active?(current_controller_name)
    if current_controller_name == controller.controller_name
      true
    end
  end

end
