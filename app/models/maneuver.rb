class Maneuver < ActiveRecord::Base
  attr_accessible :actor, :description
  
  belongs_to :bunkai
  
  validates :actor, :inclusion => { :in => %w(attacker defender),
    :message => "%{value} is not a valid actor" }, :presence => true
  validates :description, :presence => true
end
