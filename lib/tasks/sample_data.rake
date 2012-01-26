namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    # The order of these calls matters:
    make_users
    make_kata
    make_bunkai
  end
end 


def make_users
  user = User.new(:email => "user@bunkaipedia.com", :password => "foobar", 
    :password_confirmation => "foobar")
  user.save
end


def make_kata
  style = Style.create(:name => "Shobayashi ryu")
  kata = style.katas.create(:name => "Passai sho")
  10.times do |n|
    technique = kata.techniques.create(:description => "move #{n}")
    technique.create_image(:name => "65841acab9e0bf2e7d511edd94497819", :extension => "jpg")
  end
end


def make_bunkai
  kata = Kata.first
  user = User.first
  bunkai = user.bunkais.create(:title => "Defense against a grab", :kata_id => kata)
  bunkai.actions.create(:actor => "attacker", 
    :description => "The attacker grabs the defender by the lapel.")
  bunkai.actions.create(:actor => "defender",
    :description => "The defender kicks the attacker in the groin.")
  bunkai.techniques << kata.techniques[0]
  bunkai.techniques << kata.techniques[1]
end
