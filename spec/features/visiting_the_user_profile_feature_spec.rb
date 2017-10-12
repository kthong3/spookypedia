require 'rails_helper'

feature 'user profile page' do
  scenario "the user visits a profile page" do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    category2 = Category.create(name: "cutelicious")
    article1 = Article.create(category_id: category1.id, author_id: user.id, title: "test", body: "take your pick", is_published: true)
    article2 = Article.create(category_id: category2.id, author_id: user.id, title: "test2", body: "take yours", is_published: true)
    comment1 = Comment.create(article_id: article1.id, author_id: user.id, body: "asdf")
    comment2 = Comment.create(article_id: article2.id, author_id: user.id, body: "af")
    comment3 = Comment.create(article_id: article2.id, author_id: user.id, body: "afasdf")

    visit "/users/#{user.id}"

    expect(page).to have_current_path user_path(user)
    expect(page.all("h1")[1].text).to eq user.username

    within(".published-articles") do
      expect(page.first("h3").text).to eq "Authored Articles"
      articles_list = find('.authored_articles').all('li')
      expect(articles_list.count).to eq user.articles.count
    end

    within(".authored-comments") do
      expect(page.first('h3').text).to eq "Authored Comments"
      comments_list = find('.authored_comments').all('li')
      expect(comments_list.count).to eq user.comments.count
    end

    expect(page.has_no_field?(".unpublished-articles")).to eq true
  end

  scenario "a logged in user with unpublished posts visits their profile page" do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    category2 = Category.create(name: "cutelicious")
    article1 = Article.create(category_id: category1.id, author_id: user.id, title: "test", body: "take your pick", is_published: true)
    article2 = Article.create(category_id: category2.id, author_id: user.id, title: "test2", body: "take yours", is_published: true)
    comment1 = Comment.create(article_id: article1.id, author_id: user.id, body: "asdf")
    comment2 = Comment.create(article_id: article2.id, author_id: user.id, body: "af")
    comment3 = Comment.create(article_id: article2.id, author_id: user.id, body: "afasdf")

    visit '/sessions'

    fill_in('user[email]', :with => "#{user.email}")
    fill_in('user[password]', :with => "#{user.password}")
    find("input[type='submit']").click

    visit "/users/#{user.id}"

    expect(page).to have_current_path user_path(user)
    expect(page.all("h1")[1].text).to eq user.username

    within(".published-articles") do
      expect(page.first("h3").text).to eq "Authored Articles"
      articles_list = find('.authored_articles').all('li')
      expect(articles_list.count).to eq user.articles.count
    end

    within(".authored-comments") do
      expect(page.first('h3').text).to eq "Authored Comments"
      comments_list = find('.authored_comments').all('li')
      expect(comments_list.count).to eq user.comments.count
    end

    expect(page.has_no_field?(".unpublished-articles")).to eq true
  end
end
