class Messagebox < ActiveRecord::Base
  def to_param
    "#{id}=#{name}"
  end
  belongs_to :user
  has_many :messages, :dependent => :destroy
  has_many :bans, :dependent => :destroy
  has_one :messagebox_attribute, :dependent => :destroy
  attr_accessible :name
  validates :name,
  			:uniqueness => {
  				:case_sensitive => false
  			},
  			:length => {
			    :in   => 4..20,
			    :too_short => "must have at least %{count} characters",
			    :too_long  => "must have at most %{count} characters"
			}
end
