#!/bin/env ruby

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
require '../config/environment.rb'
require 'rubygems'
require 'tweetstream'

#to do - take the hash_tag as a parameter

hash_tag = 'swbay'
user = 'tweetgabteam'
password = 'helama28'

TweetStream::Client.new('dquail','helama28').track(hash_tag)do |status|
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
