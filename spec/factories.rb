Factory.define :image do |image|
  image.name "65841acab9e0bf2e7d511edd94497819"
  image.extension "jpg"
  image.viewable_id 1
end

Factory.define :technique do |technique|
  technique.description "Front kick"
  technique.kata_id 1
end

Factory.define :kata do |kata|
  kata.name "Test Kata"
end

Factory.define :action do |action|
  action.actor "defender"
  action.description "opens up a can of whupa$$!"
end

Factory.define :user do |user|
  user.email "karateka@bunkaipedia.com"
  user.password "karatedo"
  user.password_confirmation "karatedo"
end