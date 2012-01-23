class Technique < ActiveRecord::Base
  attr_accessible :description
  
  belongs_to :kata
  has_one :image, :as => :viewable
end
