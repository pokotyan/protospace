module PrototypesHelper

  def prototype_index_active?(controller_type)
    controller_type == controller_name
  end

end
