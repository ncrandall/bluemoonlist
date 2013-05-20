class TwilioJob < ActiveRecord::Base
	STATUS = { active: 0, paused: 1, cancelled: 2, done: 3 }

  validates :status, presence: true
	validates :name, presence: true, length: { maximum: 100 }
  validates :phone, presence: true, format: { with: PHONE_REGEX }

  has_many :twilio_contacts

  def status=(s)
  	write_attribute(:status, STATUS[s])
  end

  def status
  	STATUS.key(read_attribute(:status))
  end

end
