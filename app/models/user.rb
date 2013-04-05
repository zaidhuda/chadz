class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :guest, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :authentications, :dependent => :destroy
  has_many :messages, :dependent => :destroy
  has_many :msg_fav_flag, :dependent => :destroy
  has_many :ban, :dependent => :destroy
  has_one :messagebox, :dependent => :destroy
  has_one :user_info, :dependent => :destroy
  has_many :user_urls, :through => :user_info

  validates :email,
            :uniqueness => { :case_sensitive => false },
            :presence => true,
            :format => {
              :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
              :message => 'must enter an email',
            }

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

end
