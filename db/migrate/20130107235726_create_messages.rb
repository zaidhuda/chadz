class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content,              :null => false
      t.references :user
      t.references :messagebox

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :messagebox_id
    # add_index :messages, :created_at
  end
end
