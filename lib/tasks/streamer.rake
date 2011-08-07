require 'tweetstream'
#to do - take the hash_tag as a parameter
hash_tag_name = 'goduniverse'
user = 'tweetgabteam'
password = 'helama28'


def create_and_save_status(status)
  #Parse the json, create and save a status record
  puts 'create and save status'
  status = hash_tag.statuses.new
  
  status.hash_tag_id = hash.id
  status.created_at = status.created_at
  status.id_str = status.id_str
  status.in_reply_to_user_id_str = status.in_reply_to_user_id_str
  status.text = status.text
  status.retweet_count = status.retweet_count
  status.profile_image_url = status.user.profile_image_url
  status.profile_id_str = status.user.id_str
  status.profile_friends_count = status.user.followers_count
  status.profile_screen_name = status.user.screen_name
  status.in_reply_to_status_id = status.in_reply_to_status_id
  
  status.save
  
end

def create_and_save_question(status)
  puts 'create and save question'
  question = hash_tag.statuses.new
  question.status_id_str = status.id_str
  
  status.save
end

def create_and_save_announcement(status)
  puts 'create and save announcement'
  announcement = hash_tag.announcements.new
  announcement.status_id_str = status.id_str
end

def create_and_save_answer(status)
  #find the associated question
  puts 'create_and_save_answer'
  question = Question.find(:status_id_str => status.in_reply_to_status_id)

  if question
    answer = question.new
    answer.status_id_str = status.id_str
    answer.question_id_str = status.in_reply_to_status_id
    
    answer.save
  end
end

def save_status(status)
  #Create the hash tag if it doesn't exist
  puts 'In save status'
  hash_tag = HashTag.find(:name => hash_tag_name)
  if not hash_tag
    puts 'There was no hash.  Creating'
    hash_tag = HashTag.new
    hash_tag.name = hash_tag_name
    hash_tag.save    
  end
  
  #always create a status record
  create_and_save_status(status) 
  
  #create and save this as an announcement if text contains #announcement
  if status.text.include?('#announcement')
    create_and_save_announcement(status)
  end
  
  #create and save this as a question if the text contains a ?
  if status.text.include?('?')
    create_and_save_question(status)
  end
  
  #Attempt to create and save this as an answer if it's a reply
  #if the message it is a reply_to doesn't exist, a record isn't created (essentially cause we don't have an answer)
  #todo - The stream api doesn't guarantee status messages are received sequentially.  So we'll want to save replies even if there isn't a question (in case the question is delivered later)
  
  if status.in_reply_to_status_id
    create_and_save_answer(status)
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
  puts "test"
  TweetStream::Client.new(user,password).track(hash_tag_name)do |status|
  	#for debugging
  	print_status(status)

  	save_status(status)
  end

end