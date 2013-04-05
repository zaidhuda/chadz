class CreateMessageboxAttributes < ActiveRecord::Migration
  def change
    create_table :messagebox_attributes do |t|
      t.references :messagebox
      t.string :color
      t.text :custom_css
      t.boolean :public
      t.string :url

      t.timestamps
    end
    add_index :messagebox_attributes, :messagebox_id
  end
end
