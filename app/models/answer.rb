class Answer < ActiveRecord::Base
  validates_presence_of :question
  validates_presence_of :status
    
  belongs_to :question, :foreign_key => 'question_status_id', :primary_key => 'status_id_str'
  has_one :status, :foreign_key => 'status_id_str', :primary_key => 'id_str'
end
