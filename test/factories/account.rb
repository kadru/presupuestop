# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:email) { "account-#{_1}@example.com" }
    password { "verysecretpassword" }
    status { :verified }

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
