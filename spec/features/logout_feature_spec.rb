require 'rails_helper'
feature 'logout link' do

  scenario 'the user logs in from the homepage and logs out' do
    author1 = User.create(username: "TestUser", is_admin: "false", email: "test@test.none", password: "password")
    category = Category.create(name: "critters")
    article = category.articles.create(title: "This is a Halloween post", body: "STuff and things and whatnot.", author_id: author1.id, is_published: true)

    visit new_session_path
    expect(page).to have_current_path new_session_path

    within(".user-views") do
        fill_in('user[email]', :with => "test@test.none")
        fill_in('user[password]', :with => 'password')
        find("input[type='submit']").click
    end

    expect(page).to have_current_path categories_path
    expect(page.all('a')[0].text).to eq author1.username
    expect(page.all('a')[1].text).to eq "Logout"

    find("a", :text => "Logout").click

    expect(page).to have_current_path categories_path
    expect(page.all('a')[0].text).to eq "Register"
    expect(page.all('a')[1].text).to eq "Login"
  end
end
