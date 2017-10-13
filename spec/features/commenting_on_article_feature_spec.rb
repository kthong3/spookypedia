require 'rails_helper'

feature 'comment on article' do
  scenario 'the user is logged in and leaves an invalid comment' do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    article = Article.create(category_id: category1.id, author_id: user.id, title: "test2", body: "take yours", is_published: true)
    comment1 = Comment.create(article_id: article.id, author_id: user.id, body: "asdf")
    comment2 = Comment.create(article_id: article.id, author_id: user.id, body: "af")
    comment3 = Comment.create(article_id: article.id, author_id: user.id, body: "afasdf")

    visit new_session_path

    within(".user-views") do
        fill_in('user[email]', :with => "#{user.email}")
        fill_in('user[password]', :with => "#{user.password}")
        find("input[type='submit']").click
    end

    visit "/articles/#{article.id}"

    within(".submit-comment") do
        find("input[type='submit']").click
    end

    expect(page).to have_current_path article_path(article)
    expect(page.should have_css(".alert"))
    expect(page.first(".alert").text).to eq "Comment cannot be blank!"
  end

  scenario 'the user is logged in and leaves a valid comment' do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    article = Article.create(category_id: category1.id, author_id: user.id, title: "test2", body: "take yours", is_published: true)
    comment1 = Comment.create(article_id: article.id, author_id: user.id, body: "asdf")
    comment2 = Comment.create(article_id: article.id, author_id: user.id, body: "af")
    comment3 = Comment.create(article_id: article.id, author_id: user.id, body: "afasdf")

    visit new_session_path

    within(".user-views") do
        fill_in('user[email]', :with => "#{user.email}")
        fill_in('user[password]', :with => "#{user.password}")
        find("input[type='submit']").click
    end

    visit "/articles/#{article.id}"

    within(".submit-comment") do
        fill_in('comment[body]', :with => "hey")
        find("input[type='submit']").click
    end

    expect(page).to have_current_path article_path(article)
    within(".article-comments") do
      within(page.all(".comment").last) do
        expect(page.first("p").text).to eq "#{article.comments[-1].body} Written by #{article.comments[-1].author.username} on #{article.comments[-1].created_at}."
      end
    end
  end

  scenario 'the user is logged in and leaves a valid comment with html' do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    article = Article.create(category_id: category1.id, author_id: user.id, title: "test2", body: "take yours", is_published: true)
    comment1 = Comment.create(article_id: article.id, author_id: user.id, body: "asdf")
    comment2 = Comment.create(article_id: article.id, author_id: user.id, body: "af")
    comment3 = Comment.create(article_id: article.id, author_id: user.id, body: "afasdf")

    visit new_session_path

    within(".user-views") do
        fill_in('user[email]', :with => "#{user.email}")
        fill_in('user[password]', :with => "#{user.password}")
        find("input[type='submit']").click
    end

    visit "/articles/#{article.id}"

    within(".submit-comment") do
        fill_in('comment[body]', :with => "<u>underline</u> this")
        find("input[type='submit']").click
    end

    expect(page).to have_current_path article_path(article)
    within(".article-comments") do
      within(page.all(".comment").last) do
        expect(page.first("u").text).to eq "underline"
      end
    end
  end

  scenario 'the user is logged in and leaves a valid comment with an image' do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    article = Article.create(category_id: category1.id, author_id: user.id, title: "test2", body: "take yours", is_published: true)
    comment1 = Comment.create(article_id: article.id, author_id: user.id, body: "asdf")
    comment2 = Comment.create(article_id: article.id, author_id: user.id, body: "af")
    comment3 = Comment.create(article_id: article.id, author_id: user.id, body: "afasdf")

    visit new_session_path

    within(".user-views") do
        fill_in('user[email]', :with => "#{user.email}")
        fill_in('user[password]', :with => "#{user.password}")
        find("input[type='submit']").click
    end

    visit "/articles/#{article.id}"

    within(".submit-comment") do
        fill_in('comment[body]', :with => "<u>underline</u> this")
        find("input[type='submit']").click
    end

    expect(page).to have_current_path article_path(article)
    within(".article-comments") do
      within(page.all(".comment").last) do
        expect(page.first("u").text).to eq "underline"
      end
    end
  end
end