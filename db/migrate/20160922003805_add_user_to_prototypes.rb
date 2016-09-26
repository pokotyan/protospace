class AddUserToPrototypes < ActiveRecord::Migration
  def change
    add_reference :prototypes, :user, index: true, foreign_key: true
    add_column :prototypes, :likes_count, :integer, default: 0
    Prototype.all.pluck(:id).each {|id| Prototype.reset_counters(id, :likes)}
  end
end
