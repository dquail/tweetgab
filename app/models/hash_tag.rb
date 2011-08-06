class HashTag < ActiveRecord::Base
  
  #validation
  validates_presence_of :name
  
  #relationships
  has_many :statuses
end
