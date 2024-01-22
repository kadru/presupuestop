# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:email) { "account-#{_1}@example.com" }
    password { "verysecretpassword" }
    status { :verified }

    factory :unverified_account do
      status { :unverified }
    end
  end
end
