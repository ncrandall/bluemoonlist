class Request < ActiveRecord::Base
	STATUS = { active: 0, paused: 1, cancelled: 2, done: 3 }
	
	# validates :status, inclusion: { in: STATUS }
	validates :description, length: { maximum: 140 }
	validates :status, presence: true

	def status
		STATUS.key(read_attribute(:status))
	end

	def status=(s)
		write_attribute(:status, STATUS[s])
	end

	before_validation do
		if self.id.nil? && self.status.nil?
			self.status = :active
		end
	end

end
