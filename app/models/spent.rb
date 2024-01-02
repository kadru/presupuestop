# frozen_string_literal: true

class Spent < ApplicationRecord
  belongs_to :category, optional: true
  # belongs_to :subcategory
  def subcategory = nil
end
