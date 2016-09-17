class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :member, :string
    add_column :users, :profile, :string
    add_column :users, :works, :string
  end
end
