class Style < ActiveRecord::Base
  attr_accessible :name
  
  validates :name, :presence => true, :length => { :maximum => 64 }, :uniqueness => true

  has_many :katas
end
