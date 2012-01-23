class Image < ActiveRecord::Base
  attr_accessible :name, :extension
  
  belongs_to :viewable, :polymorphic => true
  
  validates :name, :presence => true, :length => { :is => 32 }    
  validates :extension, :presence => true, :length => { :is => 3 }    
end
