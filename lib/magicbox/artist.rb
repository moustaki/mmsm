module Magicbox

  class Artist

    attr_accessor :id, :name, :image_url

    def initialize(name, id, mbid = nil, image_url = nil)
      @name = name
      @id = id
      @mbid = mbid
      @image_url = image_url
    end

    def mbid
      return @mbid if @mbid
      data = JSON.parse(RestClient.get 'http://developer.echonest.com/api/v4/artist/profile', { :params => {
          :api_key => ENV['ECHONEST_API_KEY'],
          :format  => 'json',
          :id      => @id,
          :bucket  => 'id:musicbrainz'
       }})
       @mbid = data['response']['artist']['foreign_ids'][0]['foreign_id'].split(':').last
       return @mbid
    end

    def seevl_uri
      return @seevl_uri if @seevl_uri
      data = JSON.parse(RestClient.get ENV['SEEVL_SPARQL'], { :params => {
        :query  => "SELECT ?a WHERE { ?a <http://purl.org/ontology/mo/musicbrainz> <http://musicbrainz.org/artist/#{mbid}> }", 
        :format => 'json'
      }})
      bindings = data['results']['bindings']
      return nil if bindings.empty?
      @seevl_uri = bindings[0]['a']['value']
      return @seevl_uri
    end

    def subjects
      return @subjects if @subjects
      return [] unless seevl_uri
      data = JSON.parse(RestClient.get ENV['SEEVL_SPARQL'], { :params => {
        :query  => "SELECT ?s ?l WHERE { <#{seevl_uri}> <http://purl.org/dc/terms/subject> ?s . ?s <http://www.w3.org/2004/02/skos/core#prefLabel> ?l }",
        :format => 'json'
      }})
      subjects = []
      data['results']['bindings'].each do |binding|
        category_uri = binding['s']['value']
        category_label = binding['l']['value']
        subjects << { 'uri' => category_uri, 'label' => category_label }
      end
      @subjects = subjects
      return @subjects
    end 

    def random_subject_not_in(list)
      subjs = subjects.select { |s| not list.member? s }
      return subjs[rand(subjs.size)]
    end

    def self.find_most_played_artist_for_lastfm_user(user)
      data = JSON.parse(RestClient.get "http://ws.audioscrobbler.com/2.0/", { :params => {
        :method => 'user.gettopartists',
        :user => user,
        :format => 'json',
        :api_key => ENV['LASTFM_API_KEY'],
        :limit => 20
      }})
      return [] if data.nil?
      artists = []
      data['topartists']['artist'].each do |a|
        image_url = nil
        a['image'].each do |i|
          if i['size'] == 'medium'
            image_url = i['#text']
            break
          end
        end
        artist = Artist.new(a['name'], nil, a['mbid'], image_url)
        artists << artist if artist.seevl_uri
      end
      return artists
    end

    def self.find_artist_by_subject(artists, s)
      artists.each do |artist|
        artist.subjects.each do |subject|
          return artist if subject['uri'] == s['uri']
        end
      end
      return nil
    end

  end

end
