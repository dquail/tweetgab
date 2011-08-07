class Question < ActiveRecord::Base
  validates_presence_of :status
  has_one :status, foreign_key => 'status_id_str', primary_key => 'id_str'
  has_many :answers, foreign_key => 'question_id_str', primary_key=> 'status_id_str'
end
