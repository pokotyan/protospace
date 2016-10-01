module PrototypesHelper

  def prototype_index_active?(controller_type)
    if controller_type == controller_name
      'active'
    else
      ''
    end
  end

end
