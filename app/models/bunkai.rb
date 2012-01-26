class Bunkai < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user
  has_one :kata_association, :dependent => :destroy
  has_one :kata, :through => :kata_association
end
