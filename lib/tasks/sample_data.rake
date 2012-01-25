namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_kata
  end
end 


def make_users
  user = User.new(:email => "user@bunkaipedia.com", :password => "foobar", 
    :password_confirmation => "foobar")
  user.save
end


def make_kata
  kata = Kata.new(:name => "Demonstration Kata")
  kata.save
  10.times do |n|
    technique = kata.techniques.create(:description => "move #{n}")
    technique.create_image(:name => "65841acab9e0bf2e7d511edd94497819", :extension => "jpg")
  end
end
