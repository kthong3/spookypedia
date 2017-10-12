require 'rails_helper'

feature 'add article page' do
  scenario "the user adds a blank new article from the user profile page" do
    user = User.create(username: "redpanda", email: "red@panda.com", password: "redpanda", password_confirmation: "redpanda")
    category = Category.create(name: "critters")

    visit '/sessions'

    fill_in('user[email]', :with => "#{user.email}")
    fill_in('user[password]', :with => "#{user.password}")
    find("input[type='submit']").click

    visit "/users/#{user.id}"

    find("a", :text => "Create a New Article!").click

    find("input[type='submit']").click

    expect(page).to have_current_path articles_path
    expect(page.all('li')[0].text).to eq "Title can't be blank"
    expect(page.all('li')[1].text).to eq "Body can't be blank"


  end
end
