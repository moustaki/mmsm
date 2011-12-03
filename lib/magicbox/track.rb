require 'rest_client'
require 'json'

module Magicbox

  class Track

    attr_accessor :artist, :id, :title, :key, :mode, :time_signature, :loudness, :energy, :tempo, :danceability
    @set = false
    @decay = 0.5

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
      loudness = 0.0
      tracks.each do |track|
        loudness += track.loudness
      end
      loudness /= tracks.size
      loudness = (20 + loudness) / 20.0
      loudness = 0.1 if loudness < 0.1
      return loudness
    end

    def self.avatar_colour(tracks)
      key = 0.0
      tracks.each do |track|
        key += track.key
      end
      key /= (tracks.size * 11.0)
      return key
    end

    def self.avatar_frequency(tracks)
      tempo = 0.0
      tracks.each do |track|
        tempo += track.tempo
      end
      tempo /= (tracks.size * 60)
      return tempo
    end

    def self.avatar_speed(tracks)
      amp = 0.0
      tracks.each do |track|
        amp += track.danceability
      end
      amp /= tracks.size
      return amp
    end

    def self.avatar_mood(tracks)
      mode = 0.0
      norm = 0.0
      tracks.each_with_index do |track, i|
        mode += track.mode * (i ** @decay)
        norm += i ** @decay
      end
      mode /= norm
      return mode
    end

    def self.avatar_amplitude(tracks)
      nrj = 0.0
      tracks.each do |track|
        nrj += track.energy
      end
      nrj /= tracks.size
      return nrj
    end

  end

end
