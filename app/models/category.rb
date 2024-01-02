# frozen_string_literal: true

class Category < ApplicationRecord
  def self.for_select
    pluck(:name, :id)
  end
end
