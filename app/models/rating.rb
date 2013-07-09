class Rating < ActiveRecord::Base
  belongs_to :provider
  belongs_to :request
end
