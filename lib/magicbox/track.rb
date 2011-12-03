require 'rubygems'
require 'rest_client'
require 'artist'
require 'json'

module Magicbox

  class Track

    attr_accessor :artist, :id, :title, :key, :mode, :time_signature, :loudness, :energy, :tempo, :danceability

    def initialize(title, artist = nil)
        data = JSON.parse(RestClient.get 'http://developer.echonest.com/api/v4/song/search', { :params => {
          :api_key => ENV['ECHONEST_API_KEY'],
          :format  => 'json',
          :results => 1,
          :artist  => artist,
          :title   => title,
          :bucket  => 'audio_summary'
        }})
        songs = data['response']['songs']
        raise Exception.new 'Track not found' if songs.empty?
        @title = songs[0]['title']
        @id = songs[0]['id']
        @artist = Artist.new songs[0]['artist_name'], songs[0]['artist_id']
        @key = songs[0]['audio_summary']['key']
        @mode = songs[0]['audio_summary']['mode']
        @time_signature = songs[0]['audio_summary']['time_signature']
        @loudness = songs[0]['audio_summary']['loudness']
        @energy = songs[0]['audio_summary']['energy']
        @tempo = songs[0]['audio_summary']['tempo']
        @danceability = songs[0]['audio_summary']['danceability']
    end

  end

end
