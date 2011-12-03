require 'yaml'
require 'sinatra'
require 'sinatra/form_helpers'
require 'sinatra-twitter-oauth'
require 'lastfm'

# require './models'
require_relative 'lib/magicbox/artist'
require_relative 'lib/magicbox/track'

configure do
  # Base.setup
  @@config = YAML.load_file("config.yml") rescue nil || {}
  set :twitter_oauth_config,  
    :key => ENV['CONSUMER_KEY'] || @@config['consumer_key'],
    :secret   => ENV['CONSUMER_SECRET'] || @@config['consumer_secret'],
    :callback => ENV['CALLBACK_URL'] || @@config['callback_url']
  @@lastfm = Lastfm.new(@@config['lastfm_api_key'], @@config['lastfm_api_secret'])
  ENV['ECHONEST_API_KEY'] ||= @@config['echonest_api_key']
  ENV['SEEVL_SPARQL'] ||= @@config['seevl_sparql']
end

get '/lastfm/:username' do |username|
  @tracks = @@lastfm.user.get_recent_tracks(username, 3).map { |t| Magicbox::Track.new(t['name'], t['artist']['name'])}
  erb :tracks
end

get '/' do
  login_required
  erb :home
end

post '/tracks' do
  login_required
  
  @avatar = Avatar.find_or_initialize_by(:username => user.screen_name)
  track = Track.new(artist: params['track']['artist'], title: params['track']['title'])
  @avatar.tracks.create(artist: params['track']['artist'], title: params['track']['title'])
  
  redirect '/'
end
