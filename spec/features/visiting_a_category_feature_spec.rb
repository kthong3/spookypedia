require "rails_helper"

feature "visiting a category page" do
	scenario "user can see a list of articles for the category" do
		category1 = Category.create(name: "Halloween Stuff")
		author1 = User.create(username: "TestUser", is_admin: "false", email: "test@test.none", password: "password")
		author2 = User.create(username: "AlsoTestUser", is_admin: "false", email: "secondtest@test.none", password: "password")
		art1 = category1.articles.create(title: "This is a Halloween post", body: "STuff and things and whatnot.", author_id: author1.id)
		art2 = category1.articles.create(title: "What a cool costume", body: "It's so scary look at it", author_id: author2.id)

		visit "/categories/#{category1.id}"

		within(".article-box") do
      expect(page).to have_content art1.title
      expect(page).to have_content art1.title

      click_link("#{art1.title}")
    end

    expect(page).to have_current_path article_path(art1)
	end

	scenario "user can see a featured article on for the category"

end