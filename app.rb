require 'yaml'
require 'sinatra'
require 'sinatra-twitter-oauth'

# require './models'

configure do
  # Base.setup
  set :sessions, true
  @@config = YAML.load_file("config.yml") rescue nil || {}
  set :twitter_oauth_config,  
    :key => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
    :secret   => ENV['CONSUMER_SECRET'] || @@config['consumer_secret'],
    :callback => ENV['CALLBACK_URL'] || @@config['callback_url']
end

get '/' do
  login_required
  erb :home
end
