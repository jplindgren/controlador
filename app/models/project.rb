class Project < ActiveRecord::Base
	belongs_to :profile
	belongs_to :user

	after_save :new_project_notification
	after_save :project_change_notification, :if => :name_changed?

	validates_presence_of :name, :profile, :user
	validates_length_of :name, maximum: 255
	validates_uniqueness_of :name

	def url_to_follow()
		"http://localhost:3000/profiles/#{profile.id}/projects/#{id}"
	end

	def get_owner
		try(:profile) ? profile.name : "sem profile!"
		#profile.nil? ? "sem profile!" : profile.name 
	end

	private

	def new_project_notification
		ProjectMailer.new_project(self).deliver
	end

	def project_change_notification
		#ProjectMailer.project_change(self).deliver
	end
end
