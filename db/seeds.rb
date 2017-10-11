require 'faker'

admin = [1,1,1,2,2,2]
2.times do
  admin_user = User.new(username: "Admin #{admin.shift}", password: "password", email: "admin#{admin.shift}@admin.none", profile_pic_url = Faker::Avatar.image("#{admin.shift}", "300x300", "png", "set4", "bg1"))
  admin_user.save
end

10.times do
  spooky_user = User.new(username: Faker::GameOfThrones.character, password: 'password', admin: false)
  spooky_user.email = Faker::Internet.safe_email(spooky_user.username)
  spooky_user.profile_pic_url = Faker::Avatar.image(spooky_user.username, "300x300", "png", "set4", "bg1")
  spooky_user.save
end


