# frozen_string_literal: true

# Base class for mailers for this app
class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("DEFAULT_FROM_MAILER")
  layout "mailer"
end
