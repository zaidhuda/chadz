class Ban < ActiveRecord::Base
  belongs_to :user
  belongs_to :messagebox
  attr_accessible :creator, :user_id, :messagebox_id, :ip
end
