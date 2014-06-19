class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects

  validates :name, :email, presence: true
  validates :name, length: { minimum: 4, maximum: 60 }

  def is_admin?
    self.try(:admin?)
  end

  def list_valid_projects
    is_admin? ? Project.all : projects
  end
end
