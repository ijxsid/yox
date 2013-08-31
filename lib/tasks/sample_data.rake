namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Inderjit Sidhu",
                  email: "inderjitsidhu@outlook.com",
                  password: "foobar",
                  password_confirmation: "foobar")
    
    admin.toggle!(:admin)
    # But in  rails 4, we can use set admin property true, without
    # any toggling.

    99.times do |n|
      name = Faker::Name.name
      email = "inderjitsidhu#{n+1}@gmail.com"
      password = "password"
      User.create!( name: name,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end
  end
end