class Profile < ActiveRecord::Base
	has_many :projects
	belongs_to :user

	validates_presence_of :name, :email 
	
	scope :own, lambda{ |user|  }
    scope :own_by_user_id, lambda {|user_id| where(:user_id => user_id) }
    scope :own, lambda {|user| own_by_user_id(user.id) }

	def set_email(email)
		self.email = email
	end

end
