class Announcement < ActiveRecord::Base
  validates_presence_of :status
  has_one :status
end
