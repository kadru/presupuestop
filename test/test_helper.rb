# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    class << self
      alias describe context
      alias it should
    end
    # Add more helper methods to be used by all tests here...

    def translate!(*, **keyword_args)
      I18n.t(*, **keyword_args, raise: true)
    end

    def email_link(regexp, to = "foo@example.com")
      mail = email_sent(to)
      link = mail.body.to_s.gsub(/ $/, "")[regexp]

      assert_instance_of String, link
      link
    end

    def email_sent(to = "foo@example.com")
      msgs = ActionMailer::Base.deliveries

      assert_equal(1, msgs.length)
      email = msgs.first

      assert_equal(to, email.to.first)
      msgs.clear
      email
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
