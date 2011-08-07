class RenameHasTagId < ActiveRecord::Migration
  def self.up
    rename_column :statuses, :has_tag_id, :hash_tag_id
  end

  def self.down
    rename_column :statuses, :hash_tag_id, :has_tag_id    
  end
end