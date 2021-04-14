# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all


10.times do
    user = User.create(name: Faker::Name.name,
                    avatar: Faker::Avatar.image,
                    email: Faker::Internet.email(domain: 'example'),
                    password: 123456)
    user.save
    puts "Se han creado estos #{user.email} y su clave es: #{user.password}"    
    
    10.times do
        tweet = user.tweets.build(content: Faker::Book.title)
            
        tweet.save
        puts "Estos son los tweet: #{tweet.content}"  
    end

end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?