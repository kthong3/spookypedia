require 'rails_helper'

feature 'add article page' do
  scenario "the user adds a blank new article from the user profile page" do
    user = User.create(username: "redpanda", email: "red@panda.com", password: "redpanda", password_confirmation: "redpanda")
    category = Category.create(name: "critters")
    article = category.articles.create(title: "This is a Halloween post", body: "STuff and things and whatnot.", author_id: user.id, is_published: true)

    visit new_session_path

    within(".user-views") do
        fill_in('user[email]', :with => "#{user.email}")
        fill_in('user[password]', :with => "#{user.password}")
        find("input[type='submit']").click
    end

    visit "/users/#{user.id}"

    find("a", :text => "Create a New Article!").click

    within(".compose-article") do
        find("input[type='submit']").click
    end

    expect(page).to have_current_path articles_path
    expect(page.all('li')[0].text).to eq "Title can't be blank"
    expect(page.all('li')[1].text).to eq "Body can't be blank"
  end

  scenario "the user drafts a new article from the user profile page" do
    user = User.create(username: "redpanda", email: "red@panda.com", password: "redpanda", password_confirmation: "redpanda")
    category = Category.create(name: "critters")

    visit '/sessions'

    fill_in('user[email]', :with => "#{user.email}")
    fill_in('user[password]', :with => "#{user.password}")
    find("input[type='submit']").click

    visit "/users/#{user.id}"

    find("a", :text => "Create a New Article!").click

    fill_in('article[title]', :with => "Capybaras")
    fill_in('article[body]', :with => "Are the largest rodents!")

    find("input[type='submit']").click

    expect(page).to have_current_path user_path(user)
  end



end
