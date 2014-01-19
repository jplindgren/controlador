class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile #user_id included in profile

  def become_profile(options = {})
  	self.profile = Profile.new(options)
  end

  def already_has_profile?
  	profile
  end

  def is_admin?
    self.try(:admin?)
  end
end
