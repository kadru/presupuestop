# frozen_string_literal: true

require "test_helper"

class SubcategoryTest < ActiveSupport::TestCase
  describe "validations" do
    it validate_presence_of(:name)
    it validate_numericality_of(:budget).only_integer
  end
end
