require 'rails_helper'

feature 'user profile page' do
  scenario "the user visits a profile page" do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")

    visit "/users/#{user.id}"

    expect(page).to have_current_path user_path(user)
  end

end
