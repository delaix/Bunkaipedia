class Bunkai < ActiveRecord::Base
  attr_accessible :title, :kata_id

  belongs_to :user
  belongs_to :kata
  has_many :maneuvers, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :techniques
  
  validates :title, :presence => true, :length => { :maximum => 80 }
  validates :user_id, :presence => true
  validates :kata_id, :presence => true
  
  # Add techniques to this bunkai specified as separate arguments or as an array of indices.
  def add_technique_ids(*ids)
    self.technique_ids = (self.technique_ids + ids)
  end
end
