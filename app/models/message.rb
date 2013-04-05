class Message < ActiveRecord::Base
  default_scope :order => 'id desc'
  has_many :msg_fav_flag, :dependent => :destroy
  belongs_to :messagebox
  belongs_to :user
  attr_accessible :content, :messagebox_id
  profanity_filter :content, :method => 'dictionary'
  validates :content, :presence => true,
  			:length => {
  				:minimum => 5
  			}
end
