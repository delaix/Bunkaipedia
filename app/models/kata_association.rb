class KataAssociation < ActiveRecord::Base
  attr_accessible :kata_id
  
  belongs_to :bunkai
  belongs_to :kata
  
  validates :kata_id, :presence => true
  validates :bunkai_id, :presence => true
end
