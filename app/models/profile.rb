class Profile < ActiveRecord::Base
	has_many :projects
	belongs_to :user

	validates_presence_of :name, :email 

	def set_email(email)
		self.email = email
	end

end