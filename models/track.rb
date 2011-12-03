class Track
  include Mongoid::Document
  
  field :title, type: String
  
  validates_presence_of :title 
  
  belongs_to :artist
  has_and_belongs_to_many :avatar
end
