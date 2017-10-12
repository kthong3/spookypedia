require 'rails_helper'

feature 'article show page' do
  scenario "the user visits an invalid article" do
    visit "/articles/9000"

    expect(page.status_code).to eq(404)
  end

  scenario "the user visits an unpublished article" do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    article = Article.create(category_id: category1.id, author_id: user.id, title: "test2", body: "take yours")

    visit "/articles/#{article.id}"

    expect(page.status_code).to eq(404)
  end

  scenario "the user is not logged in and visits a published article" do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    article = Article.create(category_id: category1.id, author_id: user.id, title: "test2", body: "take yours", is_published: true)
    comment1 = Comment.create(article_id: article.id, author_id: user.id, body: "asdf")
    comment2 = Comment.create(article_id: article.id, author_id: user.id, body: "af")
    comment3 = Comment.create(article_id: article.id, author_id: user.id, body: "afasdf")

    visit "/articles/#{article.id}"

    expect(page).to have_current_path article_path(article)
    expect(page.first("h2").text).to eq article.title
    within(".article-info") do
      expect(page.first("span").text).to eq "Written by #{article.author.username} on #{article.created_at}."
      expect(page.first("p").text).to eq article.body
    end
    expect(page.all("h2")[1].text).to eq "Comments"
    within(".article-comments") do
      expect(page.should have_css("div.comment", :count => article.comments.count))
      within(page.first(".comment")) do
        expect(page.first("p").text).to eq "#{article.comments[0].body} Written by #{article.comments[0].author.username} on #{article.comments[0].created_at}."
      end
    end
    expect(page.has_no_field?("form")).to eq true

  end

  scenario "the user is logged in and visits a published article" do
    user = User.create(username: "test", email: "test@test.com", password: "test@test.com", password_confirmation: "test@test.com")
    category1 = Category.create(name: "adorable")
    article = Article.create(category_id: category1.id, author_id: user.id, title: "test2", body: "take yours", is_published: true)
    comment1 = Comment.create(article_id: article.id, author_id: user.id, body: "asdf")
    comment2 = Comment.create(article_id: article.id, author_id: user.id, body: "af")
    comment3 = Comment.create(article_id: article.id, author_id: user.id, body: "afasdf")

    visit '/sessions'

    fill_in('user[email]', :with => "#{user.email}")
    fill_in('user[password]', :with => "#{user.password}")
    find("input[type='submit']").click

    visit "/articles/#{article.id}"

    expect(page).to have_current_path article_path(article)
    expect(page.first("h2").text).to eq article.title
    within(".article-info") do
      expect(page.first("span").text).to eq "Written by #{article.author.username} on #{article.created_at}."
      expect(page.first("p").text).to eq article.body
    end
    expect(page.all("h2")[1].text).to eq "Comments"
    within(".article-comments") do
      expect(page.should have_css("div.comment", :count => article.comments.count))
      within(page.first(".comment")) do
        expect(page.first("p").text).to eq "#{article.comments[0].body} Written by #{article.comments[0].author.username} on #{article.comments[0].created_at}."
      end
    end
    within("form") do
      expect(page.should have_css("p"))
      expect(page.should have_css("textarea[name='comment[body]']"))
      expect(page.should have_css("input[type='submit']"))
    end
  end
end
