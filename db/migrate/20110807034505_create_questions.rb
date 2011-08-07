class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :status_id_str

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
