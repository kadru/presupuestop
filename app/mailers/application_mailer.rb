# frozen_string_literal: true

# Base class for mailers for this app
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
