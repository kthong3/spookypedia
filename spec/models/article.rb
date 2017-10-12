require 'rails_helper'

describe Article do

  describe "#log_revision" do
    it "creates a new object when an article is edited"

    it "maintains the attribute(s) of the article's previous state"

    it "records the ID of the user who edited the article"
  end

  describe "#rollback!" do

    it "returns an article's attribute to the state it was in prior to being edited"

  end

end