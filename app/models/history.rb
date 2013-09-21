class History < ActiveRecord::Base
  belongs_to :copter
  belongs_to :hospital
  belongs_to :location
end
