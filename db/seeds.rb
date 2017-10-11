require 'faker'

admin = [1,1,1,2,2,2]
2.times do
  admin_user = User.new(username: "Admin #{admin.shift}", password: "password", email: "admin#{admin.shift}@admin.none", is_admin: true, profile_pic_url = Faker::Avatar.image("#{admin.shift}", "300x300", "png", "set4", "bg1"))
  admin_user.save
end

20.times do
  spooky_user = User.new(username: Faker::GameOfThrones.character, password: 'password', is_admin: false)
  spooky_user.email = Faker::Internet.safe_email(spooky_user.username)
  spooky_user.profile_pic_url = Faker::Avatar.image(spooky_user.username, "300x300", "png", "set4", "bg1")
  if !spooky_user.save
    spooky_user.username = Faker::Hobbit.character
    spooky_user.email = Faker::Internet.safe_email(spooky_user.username)
    spooky_user.profile_pic_url = Faker::Avatar.image(spooky_user.username, "300x300", "png", "set4", "bg1")
    spooky_user.save
  end
end

Category.create!(name: 'General')
Category.create!(name: 'How-To')
Category.create!(name: 'Costume Inspiration')
Category.create!(name: 'Spooky Stories')
Category.create!(name: 'Costume Help!')
Category.create!(name: 'Favorite Halloween Candy')
Category.create!(name: 'Scary Events')
Category.create!(name: 'Cute Pets')
Category.create!(name: 'Kreepy Kids')

authors = User.pluck(:id)
categories = Category.pluck(:id)
20.times do
  article = Article.new(title: Faker::Lovecraft.tome, body: Faker::Lovecraft.paragraph(rand(10..20)), author_id: authors.sample, category_id: categories.sample)
  article.save

  article = Article.new(title: Faker::Lovecraft.location, body: Faker::Lovecraft.paragraph(rand(20..40)), author_id: authors.sample, category_id: categories.sample)
  article.save

  article = Article.new(title: Faker::StarTrek.villain, body: Faker::Lovecraft.paragraph(rand(10..20)), author_id: authors.sample, category_id: categories.sample)
  article.save

  article = Article.new(title: Faker::Zelda.location, body: Faker::Lovecraft.paragraph(rand(10..40)), author_id: authors.sample, category_id: categories.sample)
  article.save
end
