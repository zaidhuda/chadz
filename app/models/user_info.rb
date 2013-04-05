class UserInfo < ActiveRecord::Base
  attr_accessible :avatar, :name, :user_name, :user_id, :user_urls_attributes
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  has_many :user_urls
  accepts_nested_attributes_for :user_urls, :reject_if => lambda { |a| a.blank? }, :allow_destroy => true
  validates :user_name,
  			:uniqueness => {
  				:case_sensitive => false
  			},
  			:presence => true,
  			:length => {
			    :in   => 4..20,
			    :too_short => "must have at least %{count} characters",
			    :too_long  => "must have at most %{count} characters"
			  },
        :format => /^[A-Za-z0-9._\-]*\z/
  validates :name,
        :presence => true,
        :length => {
          :in   => 4..20,
          :too_short => "must have at least %{count} characters",
          :too_long  => "must have at most %{count} characters"
        },
        :format => /^[A-Za-z0-9._\-,~\#$%^&*+=<>'"?|]*\z/
  validates :avatar,
  			:presence => true
end
