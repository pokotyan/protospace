class CreatePrototypes < ActiveRecord::Migration
  def change
    create_table :prototypes do |t|
      t.integer :user_id
      t.text :catch_copy
      t.text :concept

      t.timestamps null: false
    end
  end
end
