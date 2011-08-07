class AddQuestionIdStrToAnswer < ActiveRecord::Migration
  def self.up
    #commented out.. this actually wasn't needed
    #add_column :answers, :question_id_str, :string
  end

  def self.down
    #commented out.. this actually wasn't needed  
    remove_column :answers, :question_id_str
  end
end
