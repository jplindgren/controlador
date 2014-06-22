class Ticket < ActiveRecord::Base
	belongs_to :project

	before_create :set_friendly_id

	#validates :friendly_id, presence: true
	validates :description, presence: true
	validates :project, presence: true
	validates :description, length: { maximum: 255 }

	def set_friendly_id
		self.friendly_id ||= project.next_friendly_id_ticket
	end
end
