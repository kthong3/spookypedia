require 'rails_helper'

feature 'add article page' do
  scenario "the user visits the new article page from the user profile page" do
    user = User.create(username: "redpanda", email: "red@panda.com", password: "redpanda", password_confirmation: "redpanda")
    category = Category.create(name: "critters")

    visit '/sessions'

    fill_in('user[email]', :with => "#{user.email}")
    fill_in('user[password]', :with => "#{user.password}")
    find("input[type='submit']").click

    visit "/users/#{user.id}"

    find("a", :text => "Create a New Article!").click

    expect(page).to have_current_path new_article_path
    expect(page.all("h1")[1].text).to eq "Create a new article!"
    expect(page.should have_css("select[name='article[category_id]']"))
    expect(page.should have_css("input[name='article[title]']"))
    expect(page.should have_css("textarea[name='article[body]']"))
    expect(page.should have_css("input[name='article[is_published]']"))
    expect(page.should have_css("input[type='submit']"))

  end
end
