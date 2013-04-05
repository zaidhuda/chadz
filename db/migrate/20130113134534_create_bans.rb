class CreateBans < ActiveRecord::Migration
  def change
    create_table :bans do |t|
      t.integer	   :creator
      t.string     :ip
      t.references :user
      t.references :messagebox

      t.timestamps
    end
    add_index :bans, :ip
    add_index :bans, :user_id
    add_index :bans, :messagebox_id
  end
end
