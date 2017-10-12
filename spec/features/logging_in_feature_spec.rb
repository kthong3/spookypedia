require 'rails_helper'
feature 'login page' do
  scenario 'the user sees the login form' do
    visit "/sessions"

    expect(page.all("h1")[1].text).to eq "Login"
    expect(page.should have_css("input", :count => 3))
    expect(page.should have_css("input[name='user[email]']"))
    expect(page.should have_css("input[name='user[password]']"))
    expect(page.should have_css("input[type='submit']"))
  end

  scenario 'the user enters in incorrect information' do
    author1 = User.create(username: "TestUser", is_admin: "false", email: "test@test.none", password: "password")

    visit '/sessions'

    fill_in('user[email]', :with => "test@test.none")
    find("input[type='submit']").click

    expect(page).to have_current_path new_session_path
    expect(page.first("span").text).to eq "Your email and password don't match!"
    expect(page.first("input").value).to eq "test@test.none"
  end

  scenario 'the user enters in correct information' do
    author1 = User.create(username: "TestUser", is_admin: "false", email: "test@test.none", password: "password")

    visit '/sessions'

    fill_in('user[email]', :with => "test@test.none")
    fill_in('user[password]', :with => 'password')
    find("input[type='submit']").click

    expect(page).to have_current_path categories_path
    expect(page.all('a')[0].text).to eq author1.username
    expect(page.all('a')[1].text).to eq "Logout"
  end
end
