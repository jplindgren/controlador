class Project < ActiveRecord::Base
	belongs_to :profile

	after_save :new_project_notification
	after_save :project_change_notification, :if => :name_changed?

	validates_presence_of :name


	private

	def new_project_notification
		ProjectMailer.new_project(self).deliver
	end

	def project_change_notification
		#ProjectMailer.project_change(self).deliver
	end
end
