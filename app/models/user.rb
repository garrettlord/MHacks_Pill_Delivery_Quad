class User < ActiveRecord::Base
  belongs_to :hospital
  has_many :requests
end
