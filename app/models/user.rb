class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile #user_id included in profile, if we had used belongs_to, user_id would be here.
  has_many :projects

  validates :name, :email, presence: true
  validates :name, length: { minimum: 4, maximum: 60 }

  def become_profile(options = {})
  	self.profile = Profile.new(options)
  end

  def already_has_profile?
  	profile
  end

  def is_admin?
    self.try(:admin?)
  end

  def list_valid_projects
    is_admin? ? Project.all : projects
  end
end
