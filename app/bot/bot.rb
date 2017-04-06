include Facebook::Messenger
include CloudinaryHelper

Bot.on :message do |message|
  puts "Received '#{message.inspect}' from #{message.sender}"
  Bot::Router.new(message)
end

Bot.on :postback do |postback|
  puts "Received '#{postback.inspect}' from #{postback.sender}"
  Bot::Router.new(postback)
end

Bot.on :referral do |referral|
  puts "Received '#{referral.inspect}' from #{referral.sender}"
  Bot::Router.new(referral)
end

Bot.on :delivery do |delivery|
  puts "Delivered message(s) #{delivery.ids}"
end
