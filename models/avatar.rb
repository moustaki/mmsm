class Avatar
  include Mongoid::Document
  
  field :username, type: String
  index :username, unique: true
  
  validates_presence_of :username
  
  has_and_belongs_to_many :tracks
end
