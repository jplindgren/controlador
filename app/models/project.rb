class Project < ActiveRecord::Base
	belongs_to :user
	has_many :tickets

	after_save :new_project_notification
	after_save :project_change_notification, :if => :name_changed?

	validates_presence_of :name,:user
	validates_length_of :name, maximum: 255
	validates_uniqueness_of :name

	def next_friendly_id_ticket
		return tickets.count + 1
	end

	def progress
		tickets_completed = tickets.where(completed: true).count()
		tickets_all = tickets.count
		tickets_all != 0 ? (tickets_completed / tickets_all * 100) : 0
	end

	private

	def new_project_notification
		ProjectMailer.new_project(self).deliver
	end

	def project_change_notification
		#ProjectMailer.project_change(self).deliver
	end
end
