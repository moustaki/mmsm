require 'rest_client'
require 'json'

module Magicbox

  class Track

    attr_accessor :artist, :id, :title, :key, :mode, :time_signature, :loudness, :energy, :tempo, :danceability
    @set = false

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
        return if songs.empty?
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
        @set = true
    end

    def empty?
      @set
    end

    def self.avatar_size(tracks)
      rand
    end

    def self.avatar_colour(tracks)
      rand
    end

    def self.avatar_frequency(tracks)
      rand
    end

    def self.avatar_amplitude(tracks)
      rand
    end

    def self.avatar_mood(tracks)
      rand
    end

    def self.avatar_speed(tracks)
      rand
    end

  end

end
