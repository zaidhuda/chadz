class CreateUserUrls < ActiveRecord::Migration
  def change
    create_table :user_urls do |t|
      t.references :user_info
      t.string :provider
      t.string :identifier

      t.timestamps
    end
    add_index :user_urls, :user_info_id
  end
end
