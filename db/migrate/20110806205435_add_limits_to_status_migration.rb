class AddLimitsToStatusMigration < ActiveRecord::Migration
  def self.up
    change_column :statuses, :text, :text, :limit=>240    
  end

  def self.down
  end
end
