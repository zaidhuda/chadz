class Color < ActiveRecord::Base
  belongs_to :messagebox_attribute
  attr_accessible :topline, :msgbox_name, :overall_background, :background, :foreground, :link,:link_hover, :small_link, :small_link_hover, :input, :input_focus, :input_background, :border, :border_light, :p, :super, :warning, :scrollbar_thumb, :scrollbar_background
  validates :topline, :msgbox_name, :overall_background, :background, :foreground, :link,:link_hover, :small_link, :small_link_hover, :input, :input_focus, :input_background, :border, :border_light, :p, :super, :warning, :scrollbar_thumb, :scrollbar_background,
  			:length => {
			    :is   => 6,
			    :message => "must be %{count} characters"
			},
			:format => {
				:with => /[a-fA-F0-9]/,
		    	:message => "Only hexadecimal allowed"
		    },
		    :presence => true
end

