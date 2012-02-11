class Comment < ActiveRecord::Base
  attr_accessible :text, :user_id, :bunkai_id
  
  belongs_to :user
  belongs_to :bunkai

  validates :user_id, :presence => true
  validates :bunkai_id, :presence => true
  validates :text, :presence => true
end
