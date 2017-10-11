require 'rails_helper'

feature "visiting the homepage" do
  scenario "the user sees a list of the categories, and can visit them" do

    author1 = User.create(username: "TestUser", is_admin: "false", email: "test@test.none", password: "password")
    author2 = User.create(username: "AlsoTestUser", is_admin: "false", email: "secondtest@test.none", password: "password")
    category1 = Category.create(title: "Halloween Stuff")
    category2 = Category.create(title: "Spooky")

    category1.articles.create(title: "This is a Halloween post", body: "STuff and things and whatnot.", author_id: author1.id)
    category1.articles.create(title: "What a cool costume", body: "It's so scary look at it", author_id: author2.id)
    category2.articles.create(title: "Look at this scary cat", body: "It's pretty scary", author_id: author2.id)
    category2.articles.create(title: "Check out my spooky makeup", body: "It's pretty spooky", author_id: author1.id)

    visit '/categories'

    within("#category-list-container") do
      expect(page).to have_content category1.title
      expect(page).to have_content category2.title
    end

  end

end