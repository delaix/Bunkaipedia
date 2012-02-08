class Kata < ActiveRecord::Base
  attr_accessible :name, :style_id

  has_many :techniques, :dependent => :destroy
  has_many :bunkai, :dependent => :destroy
  belongs_to :style
  
  validates :name, :presence => true, :length => { :maximum => 64 }
  validates :style_id, :presence => true
end
