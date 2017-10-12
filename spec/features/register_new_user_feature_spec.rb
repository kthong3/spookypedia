require 'rails_helper'
feature 'registration page' do
  scenario 'the user sees the registration form' do
    visit '/users/new'

    expect(page).to have_current_path new_user_path
    expect(page.should have_css("input", :count => 5))
    expect(page.should have_css("input[name='user[username]']"))
    expect(page.should have_css("input[name='user[email]']"))
    expect(page.should have_css("input[name='user[password]']"))
    expect(page.should have_css("input[name='user[password_confirmation]']"))
    expect(page.should have_css("input[type='submit']"))
  end

  scenario 'the user properly registers' do
    visit '/users/new'

    fill_in('user[username]', :with => "eric")
    fill_in('user[email]', :with => "red@panda.com")
    fill_in('user[password]', :with => "redpanda")
    fill_in('user[password_confirmation]', :with => "redpanda")
    find("input[type='submit']").click

    expect(page).to have_current_path categories_path
  end

  scenario 'the user properly registers' do
    visit '/users/new'

    find("input[type='submit']").click

    expect(page).to have_current_path users_path
    expect(page.all('li')[0].text).to eq "Password can't be blank"
    expect(page.all('li')[1].text).to eq "Username can't be blank"
    expect(page.all('li')[2].text).to eq "Email can't be blank"

    fill_in('user[username]', :with => "eric")
    fill_in('user[email]', :with => "red@panda.com")
    fill_in('user[password]', :with => "redpanda")
    find("input[type='submit']").click

    expect(page).to have_current_path users_path
    expect(page.all('li')[0].text).to eq "Password confirmation doesn't match Password"
  end
end
