require 'rails_helper'

describe Revision do
  let(:user) { User.create!(username: "Test User", email: "test@test", password: "password") }
  let(:editor) { User.create!(username: "Editing User", email: "edit@test", password: "password") }
  let(:category) { Category.create!(name: "Spooky") }
  let(:article) { Article.create!(title: "How I Did It", body: "The story of Young Frankenstein", author_id: user.id, category_id: category.id) }

  describe "revision object's attributes" do
    before(:each) do
      article.editor = editor
    end

    it "stores the name of the attribute changed (e.g. 'body')" do
      article.update_attributes(body: "Edited article body")
      revision = Revision.last
      expect(revision.revised_attribute).to eq "body"
    end

    it "stores an attribute of the object before it was updated" do
      article.update_attributes(body: "This article body has been edited")
      revision = Revision.last
      expect(revision.before_value).to eq article.previous_changes[:body][0]
    end

    it "stores the edited attribute value of the object" do
      article.update_attributes(body: "Let's everybody edit this article for funsies")
      revision = Revision.last
      expect(revision.revised_value).to eq article.previous_changes[:body][1]
    end

  end
end