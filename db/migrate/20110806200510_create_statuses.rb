class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.integer :has_tag_id
      t.datetime :created_at
      t.string :id_str
      t.string :in_reply_to_user_id_str
      t.string :text
      t.integer :retweet_count
      t.string :profile_image_url
      t.string :profile_id_str
      t.integer :profile_friends_count
      t.string :profile_screen_name
      t.string :in_reply_to_status_id

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
