module Magicbox

  class Artist

    attr_accessor :id, :name

    def initialize(name, id)
      @name = name
      @id = id
    end

    def mbid
      data = JSON.parse(RestClient.get 'http://developer.echonest.com/api/v4/artist/profile', { :params => {
          :api_key => ENV['ECHONEST_API_KEY'],
          :format  => 'json',
          :id      => @id,
          :bucket  => 'id:musicbrainz'
       }})
       return data['response']['artist']['foreign_ids'][0]['foreign_id'].split(':').last
    end

  end

end
