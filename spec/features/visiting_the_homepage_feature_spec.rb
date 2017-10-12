require 'rails_helper'

feature "visiting the homepage" do

  scenario "the user sees a list of the categories, and can visit them" do
    category1 = Category.create(name: "Halloween Stuff")

    visit '/'

    within("#category-list-container") do
      expect(page).to have_content category1.name
      click_link("#{category1.name}")
    end

    expect(page).to have_current_path category_path(category1)
  end

  scenario "the user can see a couple of the articles from a category underneath the category's title" do
    category1 = Category.create(name: "Halloween Stuff")
    category2 = Category.create(name: "Spooky")

    author1 = User.create(username: "TestUser", is_admin: "false", email: "test@test.none", password: "password")
    author2 = User.create(username: "AlsoTestUser", is_admin: "false", email: "secondtest@test.none", password: "password")

    art1 = category1.articles.create(title: "This is a Halloween post", body: "STuff and things and whatnot.", author_id: author1.id)
    art2 = category1.articles.create(title: "What a cool costume", body: "It's so scary look at it", author_id: author2.id)
    art3 = category2.articles.create(title: "Look at this scary cat", body: "It's pretty scary", author_id: author2.id)
    art4 = category2.articles.create(title: "Check out my spooky makeup", body: "It's pretty spooky", author_id: author1.id)

    visit '/'

    within("#category-list-container") do
      expect(page).to have_content art1.title
      expect(page).to have_content art2.title
      expect(page).to have_content art3.title
      expect(page).to have_content art4.title
      click_link("#{category1.name}")
    end

    expect(page).to have_current_path category_path(category1)
  end

  scenario "the user can log into their account"

  scenario "the user can log out of their account"

  scenario "the user can register"

end
