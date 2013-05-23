class TwilioJob < ActiveRecord::Base
	STATUS = { active: 0, paused: 1, cancelled: 2, done: 3 }

  validates :status, presence: true
	validates :name, presence: true, length: { maximum: 100 }
  validates :phone, presence: true, format: { with: PHONE_REGEX }
  validates :call_sid, allow_nil: true, length: { is: 36 }

  has_many :twilio_contacts
  # This relationship will be changed to REST call eventually (see class diagram)
  belongs_to :request

  def status=(s)
  	write_attribute(:status, STATUS[s])
  end

  def status
  	STATUS.key(read_attribute(:status))
  end

  before_validation do
    if self.id.nil? && self.status.nil?
      self.status = :active
    end
  end
end
