class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.string :status_id_str
      t.string :question_id_str

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
