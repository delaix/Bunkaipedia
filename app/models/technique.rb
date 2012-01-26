class Technique < ActiveRecord::Base
  attr_accessible :description
  
  belongs_to :kata
  has_one :image, :as => :viewable
  has_and_belongs_to_many :bunkais
  
  validates :kata_id, :presence => true
  validates :description, :presence => true, :length => { :maximum => 80 }
end
