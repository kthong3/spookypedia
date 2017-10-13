require 'faker'

User.delete_all
Category.delete_all
Article.delete_all
Comment.delete_all

admin_user = User.new(username: "Spooky Admin", password: "32822c-2fa8d0", email: "spooky_avner@test.none", is_admin: true, profile_pic_url: Faker::Avatar.image("spooky-avner", "300x300", "png", "set4", "bg1"))
admin_user.save


5.times do
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
Category.create!(name: 'Halloween Pets')
Category.create!(name: 'Costume Help!')


authors = User.pluck(:id)
categories = Category.pluck(:id)
5.times do
  article = Article.new(title: Faker::Lovecraft.tome, body: "Eldritch tenebrous indescribable unutterable daemoniac iridescence nameless abnormal. Antiquarian antediluvian daemoniac fungus charnel gibbous squamous accursed. Manuscript lurk decadent iridescence gibbering. Dank loathsome tenebrous. Singular unnamable shunned eldritch noisome spectral non-euclidean madness. Immemorial unmentionable foetid effulgence tenebrous stygian. Decadent non-euclidean gibbous stygian fungus unutterable. Amorphous antiquarian lurk unmentionable charnel antediluvian. Fainted swarthy mortal gibbous. Stygian shunned iridescence cyclopean gambrel dank immemorial. Madness shunned indescribable. Foetid loathsome tentacles. \n

    Fainted singular immemorial tentacles blasphemous unnamable charnel. Dank fainted nameless gibbous. Spectral comprehension singular iridescence shunned dank immemorial unnamable. Stygian unnamable madness spectral tentacles noisome manuscript charnel. Ululate stench blasphemous. Iridescence singular mortal ululate blasphemous. Cyclopean squamous charnel. \n

    Gibbous abnormal furtive antiquarian. Spectral cyclopean loathsome hideous immemorial ululate antediluvian stench. Non-euclidean spectral nameless noisome daemoniac stench charnel. Antiquarian unnamable gibbering indescribable blasphemous daemoniac spectral swarthy. Nameless effulgence spectral noisome.", author_id: authors.sample, category_id: categories.sample, is_published: true)
  article.save

  article = Article.new(title: Faker::Lovecraft.location, body: "Fainted mortal madness blasphemous decadent eldritch. Foetid decadent gibbering singular cat amorphous unmentionable. Dank nameless spectral foetid ululate. Lurk antiquarian indescribable accursed eldritch squamous. Foetid gibbous swarthy. Comprehension stench tentacles abnormal indescribable singular tenebrous shunned. Cat ululate daemoniac amorphous. Stygian mortal accursed effulgence. Antediluvian non-euclidean hideous nameless. Mortal non-euclidean unmentionable. Dank furtive manuscript amorphous iridescence unmentionable swarthy squamous. Gambrel gibbering nameless dank iridescence. Lurk daemoniac fainted comprehension stygian. Immemorial tentacles mortal iridescence foetid blasphemous fainted cat. Accursed gibbering swarthy unutterable effulgence spectral. Charnel squamous iridescence furtive unnamable blasphemous daemoniac amorphous. \n
    Gibbous abnormal furtive antiquarian. Spectral cyclopean loathsome hideous immemorial ululate antediluvian stench. Non-euclidean spectral nameless noisome daemoniac stench charnel. Antiquarian unnamable gibbering indescribable blasphemous daemoniac spectral swarthy. Nameless effulgence spectral noisome. \n
    Mortal hideous tenebrous amorphous cat stench. Madness singular cat manuscript lurk cyclopean eldritch. Stygian gibbering noisome nameless lurk eldritch. Comprehension spectral blasphemous. Lurk madness unmentionable comprehension. Charnel gambrel antediluvian. Stygian decadent swarthy. Iridescence gibbering nameless comprehension indescribable effulgence unutterable manuscript. Swarthy comprehension antiquarian unnamable non-euclidean amorphous gibbous. Gambrel shunned immemorial furtive squamous ululate.", author_id: authors.sample, category_id: categories.sample, is_published: true)
  article.save
end

# 20.times do
#   Comment.create!(article_id: Article.pluck(:id).sample, author_id: User.pluck(:id).sample, body: Faker::Lovecraft.tome)
# end
