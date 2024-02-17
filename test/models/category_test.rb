# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  describe "assocations" do
    should have_many(:subcategories)
    should belong_to(:account)
  end
end
