class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :hospital
  belongs_to :destination
  has_many :requested_medicines
end
