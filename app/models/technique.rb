class Technique < ActiveRecord::Base
  require 'aws/s3'
  
  attr_accessible :description, :image, :kata_id

  has_attached_file :image, 
    { 
      :styles => { :thumbnail => "30x30", :small => "144x144>", :original => "720x720>" }
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
 
  belongs_to :kata
  has_and_belongs_to_many :bunkai
   
  validates :kata_id, :presence => true
  validates :description, :presence => true, :length => { :maximum => 80 }
  validates_attachment_presence :image
end
