class UserUrl < ActiveRecord::Base
  belongs_to :user_info
  attr_accessible :identifier, :provider
  validates :identifier, :provider,
  			:presence => true
end
