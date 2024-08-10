# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { "vivienda" }
    account

    factory :category_with_subcategories do
      transient do
        subcategories_count { 1 }
      end

      after(:create) do |category, context|
        create_list(:subcategory, context.subcategories_count, category:)
      end

      trait :budget1000 do
        budget { 1_000 }
      end
    end
  end
end
