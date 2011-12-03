class Artist
  include Mongoid::Document
  
  has_many :tracks
end
