class Bunkai < ActiveRecord::Base
  attr_accessible :title, :kata_id

  belongs_to :user
  belongs_to :kata
  has_many :actions
  has_and_belongs_to_many :techniques
  
  validates :title, :presence => true, :length => { :maximum => 80 }
  validates :user_id, :presence => true
  validates :kata_id, :presence => true
end
