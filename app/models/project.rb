class Project < ActiveRecord::Base
	belongs_to :user

	after_save :new_project_notification
	after_save :project_change_notification, :if => :name_changed?

	validates_presence_of :name,:user
	validates_length_of :name, maximum: 255
	validates_uniqueness_of :name

	private

	def new_project_notification
		ProjectMailer.new_project(self).deliver
	end

	def project_change_notification
		#ProjectMailer.project_change(self).deliver
	end
end
