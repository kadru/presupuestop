# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:email) { "account-#{_1}@example.com" }
    password { "verysecretpassword" }
    status { :verified }

    trait :recently_password_reset do
      after(:build) do |account, _context|
        account.build_password_reset_key(
          key: SecureRandom.alphanumeric(10),
          deadline: 24.hours.from_now,
          email_last_sent: 0.1.seconds.ago
        )
      end
    end

    trait :with_expenses do
      transient do
        expenses_count { 1 }
        category_for_expense { create(:category_with_subcategories) }
      end

      after(:create) do |account, context|
        create_list(:expense,
                    context.expenses_count,
                    account:,
                    category: context.category_for_expense,
                    subcategory: context.category_for_expense.subcategories.last)
      end
    end

    factory :unverified_account do
      status { :unverified }

      trait :expired_grace_period do
        after(:build) do |account, _context|
          account.build_verification_key(
            key: SecureRandom.alphanumeric(10),
            requested_at: 25.hours.ago,
            email_last_sent: 25.hours.ago
          )
        end
      end

      trait :within_grace_period do
        after(:build) do |account, _context|
          account.build_verification_key(
            key: SecureRandom.urlsafe_base64(10),
            requested_at: Time.zone.now
          )
        end
      end
    end
  end
end
