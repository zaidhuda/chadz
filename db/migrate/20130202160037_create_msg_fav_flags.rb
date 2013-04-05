class CreateMsgFavFlags < ActiveRecord::Migration
  def change
    create_table :msg_fav_flags do |t|
      t.boolean :fav
      t.references :user
      t.references :message

      t.timestamps
    end
    add_index :msg_fav_flags, :user_id
    add_index :msg_fav_flags, :message_id
  end
end
