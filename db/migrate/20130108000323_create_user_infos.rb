class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :name,           :null => false
      t.string :user_name,      :null => false
      t.string :avatar,         :null => false
      t.references :user

      t.timestamps
    end
    add_index :user_infos, :user_id
    add_index :user_infos, :user_name,	 :unique => true
  end
end
