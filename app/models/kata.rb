class Kata < ActiveRecord::Base
  attr_accessible :name

  has_many :techniques, :dependent => :destroy
  has_many :bunkais, :dependent => :destroy
  belongs_to :style
  
  validates :name, :presence => true, :length => { :maximum => 64 }
  validates :style_id, :presence => true
end
