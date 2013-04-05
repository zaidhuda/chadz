class CreateMessageboxes < ActiveRecord::Migration
  def change
    create_table :messageboxes do |t|
      t.string :name,              :null => false
      t.references :user

      t.timestamps
    end
    add_index :messageboxes, :user_id
    add_index :messageboxes, :name, 	:unique => true
  end
end
