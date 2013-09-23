class User < ActiveRecord::Base
  # attr_accessible :name, :phone_number, :type
  belongs_to :hospital
  has_many :requests
end
