namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Inderjit Sidhu",
                  email: "inderjitsidhu@outlook.com",
                  password: "foobar",
                  password_confirmation: "foobar")

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