class MsgFavFlag < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  attr_accessible :fav, :user_id, :message_id
end
