class Technique < ActiveRecord::Base
  attr_accessible :description, :image

  has_attached_file :image, 
    :styles => { :small => "144x144>", :large => "720x720>" }
 
  belongs_to :kata
  has_and_belongs_to_many :bunkais
   
  validates :kata_id, :presence => true
  validates :description, :presence => true, :length => { :maximum => 80 }
  validates_attachment_presence :image
end
