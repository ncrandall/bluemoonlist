class TwilioJob < ActiveRecord::Base
	STATUS = { active: 0, paused: 1, cancelled: 2, done: 3 }
  TYPE = { call: 0, text: 1 }

  validates :status, presence: true
  validates :type, presence: true
	validates :name, presence: true, length: { maximum: 100 }
  validates :phone, presence: true, format: { with: PHONE_REGEX }
  validates :call_sid, allow_nil: true, length: { is: 36 }

  has_many :twilio_contacts, dependent: :destroy
  # This relationship will be changed to REST call eventually (see class diagram)
  belongs_to :request

  def status=(s)
    write_attribute(:status, STATUS[s])
  end

  def status
    STATUS.key(read_attribute(:status))
  end

  def type=(t)
    write_attribute(:type, TYPE[t])
  end

  def type
    TYPE.key(read_attribute(:type))
  end

  before_validation do
    if self.id.nil? && self.status.nil?
      self.status = :active
    end
  end
end
