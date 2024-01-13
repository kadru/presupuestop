# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { "vivienda" }

    factory :category_with_subcategories do
      transient do
        subcategories_count { 1 }
      end

      subcategories do
        Array.new(subcategories_count) { association :subcategory }
      end
    end
  end
end