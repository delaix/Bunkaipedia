class TechniqueAssociation < ActiveRecord::Base
  attr_accessible :technique_id
  
  belongs_to :bunkai
  belongs_to :technique
  
  validates :bunkai_id, :presence => true
  validates :technique_id, :presence => true
end
