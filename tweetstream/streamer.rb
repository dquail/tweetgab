#!/bin/env ruby

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
require '../config/environment.rb'
require 'rubygems'
require 'tweetstream'

#TweetStream::Client.new('dquail','helama28').sample do |status|
#	#the status object is a special hash with 
#	#method access to its keys
#	puts "#{status.text}"
#end

TweetStream::Client.new('dquail','helama28').track('swbay')do |status|
	puts "#{status.text}"
end
