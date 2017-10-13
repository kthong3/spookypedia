require 'rails_helper'

describe Article do
  let(:user) { User.create!(username: "Test User", email: "test@test", password: "password") }
  let(:editor) { User.create!(username: "Editing User", email: "edit@test", password: "password") }
  let(:category) { Category.create!(name: "Spooky") }
  let(:article) { Article.create!(title: "How I Did It", body: "The story of Young Frankenstein", author_id: user.id, category_id: category.id) }

  describe "#log_revision" do
    before(:each) do
      article.editor = editor
    end
    it "creates a new object when an article is edited" do
      expect {
        article.update_attributes(body: "Editing this")
        }.to change(Revision, :count).by(1)
    end

    it "maintains the attribute(s) of the article's previous state" do
      article.update_attributes(body: "Editing this")
      revision = Revision.last

      expect(revision.revised_attribute).not_to be_nil
    end

    it "records the ID of the user who edited the article" do
      article.editor = editor
      article.update_attributes(body: "Editing this")
      revision = Revision.last
      # I don't know if this will work??
      expect(revision.editor_id).to eq editor.id
    end
  end

  describe "#rollback!" do
    before(:each) do
      article.editor = editor
    end

    it "returns an article's attribute to the state it was in prior to being edited" do
      article.update_attributes(body: "Editing this")
      revision = Revision.last

      article.rollback!(revision)
      expect(article.body).to eq "The story of Young Frankenstein"
    end

  end

end