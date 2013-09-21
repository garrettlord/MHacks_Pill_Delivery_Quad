class Copter < ActiveRecord::Base
  belongs_to :hospital
  has_many :histories
end
