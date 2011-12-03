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
  @@lastfm = Lastfm.new(ENV['LASTFM_API_KEY'] || @@config['lastfm_api_key'], ENV['LASTFM_API_SECRET'] || @@config['lastfm_api_secret'])
  ENV['LASTFM_KEY'] ||= @@lastfm
  ENV['ECHONEST_API_KEY'] ||= @@config['echonest_api_key']
  ENV['SEEVL_SPARQL'] ||= @@config['seevl_sparql']
end

get '/lastfm/:username' do |username|
  @tracks = @@lastfm.user.get_recent_tracks(username, 10).map { |t| Magicbox::Track.new(t['name'], t['artist']['content'])}.select {|t| t.empty?}
  erb :tracks
end

get '/fight/:user1/:user2' do |user1, user2|
  @user1 = user1
  @user2 = user2
  @artists1 = Magicbox::Artist.find_most_played_artist_for_lastfm_user(user1)
  @artists2 = Magicbox::Artist.find_most_played_artist_for_lastfm_user(user2)
  erb :fight
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
