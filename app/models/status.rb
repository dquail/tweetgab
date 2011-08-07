class Status < ActiveRecord::Base
    #validation
    validates_presence_of :hash_tag_id, :text
    validates_uniqueness_of :id_str
    #relationships
    belongs_to :hash_tag
    
end
