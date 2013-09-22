class Hospital < ActiveRecord::Base
	has_many :users
	has_many :copters
	has_many :destinations
	has_many :requests
end
