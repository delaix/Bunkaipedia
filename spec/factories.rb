Factory.define :image do |image|
  image.name "65841acab9e0bf2e7d511edd94497819"
  image.extension "jpg"
  image.viewable_id 1
end

Factory.define :technique do |technique|
  technique.description "Front kick"
  technique.kata_id 1
  technique.image File.new("#{Rails.root}/spec/fixtures/images/test.png")
end

Factory.define :kata do |kata|
  kata.name "Test Kata"
  kata.style_id 1
end

Factory.define :maneuver do |maneuver|
  maneuver.actor "defender"
  maneuver.description "opens up a can of whupa$$!"
end

Factory.define :user do |user|
  user.email "karateka@bunkaipedia.com"
  user.password "karatedo"
  user.password_confirmation "karatedo"
end

Factory.define :style do |style|
  style.name "Shobayashi ryu"
end

Factory.sequence :email do |n|
  "user-#{n}@bunkaipedia.com"
end
