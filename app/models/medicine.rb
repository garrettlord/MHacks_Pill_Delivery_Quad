class Medicine < ActiveRecord::Base
  belongs_to :hospital
  has_many :requested_medicines
end
