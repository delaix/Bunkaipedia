class Technique < ActiveRecord::Base
  has_one :image, :as => :viewable
end
