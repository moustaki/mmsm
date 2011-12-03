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

    def seevl_uri
      data = JSON.parse(RestClient.get ENV['SEEVL_SPARQL'], { :params => {
        :query  => "SELECT ?a WHERE { ?a <http://purl.org/ontology/mo/musicbrainz> <http://musicbrainz.org/artist/#{mbid}> }", 
        :format => 'json'
      }})
      bindings = data['results']['bindings']
      raise Exception.new 'No corresponding Seevl URI' if bindings.empty?
      return bindings[0]['a']['value']
    end

    def subjects
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
      return subjects
    end 

  end

end
