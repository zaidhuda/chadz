class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.references :messagebox_attribute
      t.string :topline,             :default => "80BC00"
      t.string :msgbox_name,         :default => "888888"
      t.string :overall_background,  :default => "FFFFFF"
      t.string :background,          :default => "F0F0F0"
      t.string :foreground,          :default => "FFFFFF"
      t.string :link,                :default => "80BC00"
      t.string :link_hover,          :default => "4E8A00"
      t.string :small_link,          :default => "777777"
      t.string :small_link_hover,    :default => "444444"
      t.string :input,               :default => "80BC00"
      t.string :input_focus,         :default => "80BC00"
      t.string :input_background,    :default => "F0F0F0"
      t.string :border,              :default => "DDDDDD"
      t.string :border_light,        :default => "F0F0F0"
      t.string :p,                   :default => "555555"
      t.string :super,               :default => "AAAAAA"
      t.string :warning,             :default => "FF3C46"
      t.string :scrollbar_thumb,     :default => "DDDDDD"
      t.string :scrollbar_background,:default => "888888"

      t.timestamps
    end
    add_index :colors, :messagebox_attribute_id
  end
end
# "80BC00" 8436736
# "888888" 8947848
# "FFFFFF" 16777215
# "F0F0F0" 15790320
# "FFFFFF" 16777215
# "80BC00" 8436736
# "4E8A00" 5147136
# "777777" 7829367
# "444444" 4473924
# "80BC00" 8436736
# "80BC00" 8436736
# "F0F0F0" 15790320
# "DDDDDD" 14540253
# "F0F0F0" 15790320
# "555555" 5592405
# "AAAAAA" 11184810
# "FF3C46" 16727110
# "DDDDDD" 14540253
# "888888" 8947848