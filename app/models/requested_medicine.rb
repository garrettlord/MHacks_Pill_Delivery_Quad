class RequestedMedicine < ActiveRecord::Base
  belongs_to :request
  belongs_to :medicine
end
