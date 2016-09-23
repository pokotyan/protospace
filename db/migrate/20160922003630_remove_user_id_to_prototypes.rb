class RemoveUserIdToPrototypes < ActiveRecord::Migration
  def change
    remove_column :prototypes, :user_id
  end
end
