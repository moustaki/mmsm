require 'yaml'
require 'sinatra'
require 'sinatra/form_helpers'
require 'sinatra-twitter-oauth'

require './models'

configure do
  Base.setup
  set :sessions, true
  @@config = YAML.load_file("config.yml") rescue nil || {}
  set :twitter_oauth_config,  
    :key => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
    :secret   => ENV['CONSUMER_SECRET'] || @@config['consumer_secret'],
    :callback => ENV['CALLBACK_URL'] || @@config['callback_url']
end

get '/' do
  login_required
  
  Avatar.all.each { |a| p a }
  @avatar = Avatar.find_or_create_by(:username => user.screen_name)
  
  erb :home
end

post '/tracks' do
  login_required
  
  @avatar = Avatar.find_or_initialize_by(:username => user.screen_name)
  @avatar.tracks << Track.new(artist: params['track']['artist'], title: params['track']['title'])
  @avatar.save
  
  redirect '/'
end
