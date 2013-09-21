class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :hospital
  belongs_to :destination
end
