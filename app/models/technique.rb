class Technique < ActiveRecord::Base
  require 'aws/s3'
  
  attr_accessible :description, :image, :kata_id

  has_attached_file :image, 
    :styles => { :thumbnail => "30x30", :small => "144x144>", :original => "720x720>" },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => ":attachment/:id/:style/:filename",
    :bucket => 'bunkaipedia'
 
  belongs_to :kata
  has_and_belongs_to_many :bunkais
   
  validates :kata_id, :presence => true
  validates :description, :presence => true, :length => { :maximum => 80 }
  validates_attachment_presence :image
end
