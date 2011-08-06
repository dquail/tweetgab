class Status < ActiveRecord::Base
    #validation
    validates_presence_of :hash_tag_id, :text
    
    #relationships
    belongs_to :hash_tag
    
end
