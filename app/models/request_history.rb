class RequestHistory < ActiveRecord::Base
	default_scope -> { order("created_at DESC") }
	validates :request_id, presence: true
	belongs_to :request

  def to_text
    case status
    when "calling"
      provider = RequestProvider.where(id: request_provider_id).first.provider
      "Calling #{provider.company_name}"
    when "paused"
      "Connecting user to call"
    when "working"
      "Waiting for #{provider.company_name} to complete work request"
    when "invoicing"
      "Waiting for user payment for work"
    when "done"
      "Request has been finished"
    else
      status
    end
  end
end
