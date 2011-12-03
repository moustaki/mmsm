require 'mongoid'

class Base
  def self.setup
    Mongoid.configure do |config|
      if ENV['MONGOHQ_URL']
        conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
        uri = URI.parse(ENV['MONGOHQ_URL'])
        config.master = conn.db(uri.path.gsub(/^\//, ''))
      else
        config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('test')
      end
    end
  end
end

class Avatar
  include Mongoid::Document
  
  field :username, type: String
  index :username, unique: true
  
  validates_presence_of :username
  
  embeds_many :tracks
end

class Track
  include Mongoid::Document
  field :artist, type: String
  field :title, type: String
end
