class Kata < ActiveRecord::Base
  attr_accessible :name
  
  validates :name, :presence => true, :length => { :maximum => 64 }

  has_many :techniques
  has_many :bunkais
  belongs_to :style
end
