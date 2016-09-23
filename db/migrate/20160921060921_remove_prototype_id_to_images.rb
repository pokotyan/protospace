class RemovePrototypeIdToImages < ActiveRecord::Migration
  def change
    remove_column :images, :prototype_id
  end
end
