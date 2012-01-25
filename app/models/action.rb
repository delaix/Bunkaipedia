class Action < ActiveRecord::Base
  attr_accessible :actor, :description
  
  validates :actor, :inclusion => { :in => %w(attacker defender),
    :message => "%{value} is not a valid actor" }, :presence => true
  validates :description, :presence => true
end
