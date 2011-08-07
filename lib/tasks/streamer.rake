require 'tweetstream'
#to do - take the hash_tag as a parameter
hash_tag_name = 'swbay'
user = 'tweetgabteam'
password = 'helama28'


def create_and_save_status(status, hash_tag)
  #Parse the json, create and save a status record
  puts 'create and save status'
  new_status = hash_tag.statuses.new
  
  new_status.created_at = status.created_at
  new_status.id_str = status.id_str
  new_status.in_reply_to_user_id_str = status.in_reply_to_user_id_str
  new_status.text = status.text
  new_status.retweet_count = status.retweet_count
  new_status.profile_image_url = status.user.profile_image_url
  new_status.profile_id_str = status.user.id_str
  new_status.profile_friends_count = status.user.followers_count
  new_status.profile_screen_name = status.user.screen_name
  new_status.in_reply_to_status_id = status.in_reply_to_status_id
  
  new_status.save
  puts 'saved status'
  
end

def create_and_save_question(status, hash_tag)
  puts 'create and save question'
  question = hash_tag.statuses.find_by_id_str(status.in_reply_to_id_str)
  question.status_id_str = status.id_str
  
  question.save
end

def create_and_save_announcement(status, hash_tag)
  puts 'create and save announcement'
  announcement = hash_tag.announcements.new
  announcement.status_id_str = status.id_str
  
  announcement.save
end

def create_and_save_answer(status)
  #find the associated question
  puts 'create_and_save_answer'
  question = Question.find_by_status_id_str(status.in_reply_to_status_id)

  if question
    answer = question.new
    answer.status_id_str = status.id_str
    answer.question_id_str = status.in_reply_to_status_id
    
    answer.save
  end
end

def save_status(status, tag_name)
  #Create the hash tag if it doesn't exist
  puts "in save status"
  puts " for #{tag_name}"
  hash_tag = HashTag.find_by_name(tag_name)
  puts 'finished tag'
  if hash_tag
    puts 'Tag found'
  else
    puts 'There was no existing hash.  Creating'
    hash_tag = HashTag.new
    hash_tag.name = tag_name
    hash_tag.save    
  end
  
  #always create a status record
  create_and_save_status(status, hash_tag) 
  
  #create and save this as an announcement if text contains #announcement
  if status.text.include?('#announcement')
    #todo - uncomment out after demo ... when this is working
    #create_and_save_announcement(status, hash_tag)
  end
  
  #create and save this as a question if the text contains a ?
  if status.text.include?('?')
    #todo - uncomment out after demo ... when this is working
    #create_and_save_question(status, hash_tag)
  end
  
  #Attempt to create and save this as an answer if it's a reply
  #if the message it is a reply_to doesn't exist, a record isn't created (essentially cause we don't have an answer)
  #todo - The stream api doesn't guarantee status messages are received sequentially.  So we'll want to save replies even if there isn't a question (in case the question is delivered later)
  
  if status.in_reply_to_status_id
    #todo - uncomment out after demo ... when this is working    
    #create_and_save_answer(status, hash_tag)
  end
  
end

def print_status(status)
  #print this bad boy out
	puts "Text - #{status.text}"
	puts "Created at - #{status.created_at}"
	puts "Status id_str - #{status.id_str}"
	puts "in_reply_to_user_id_str - #{status.in_reply_to_user_id_str}"
	puts "retweet_count - #{status.retweet_count}"	
	puts "profile_image_url - #{status.user.profile_image_url}"
	puts "user_id_str - #{status.user.id_str}"
	puts "followers - #{status.user.followers_count}"
	puts "screen name: #{status.user.screen_name}"	
	puts "inreplyto - #{status.in_reply_to_status_id}"
  
end

task :stream_hash_tag => :environment do 
  #to do - take the hash_tag as a parameter
  #user = 'test'
  puts "User: #{user} "
  puts "Hash tag: #{hash_tag_name}"
  TweetStream::Client.new(user,password).track(hash_tag_name)do |status|
  	#for debugging
  	print_status(status)

  	save_status(status, hash_tag_name)
  end

end