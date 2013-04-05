class MessageboxAttribute < ActiveRecord::Base
  belongs_to :messagebox
  has_one :color, :dependent => :destroy
  attr_accessible :public, :url, :custom_css
end
