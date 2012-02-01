class Maneuver < ActiveRecord::Base
  attr_accessible :actor, :description, :image
  
  belongs_to :bunkai
  has_attached_file :image, 
    :styles => { :thumbnail => "32x32>", :small => "144x144>", :large => "720x720>" }

  validates_attachment_size :image, :less_than => 1.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']  
  validates :actor, :inclusion => { :in => %w(attacker defender),
    :message => "%{value} is not a valid actor" }, :presence => true
  validates :description, :presence => true
end
