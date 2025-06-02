# frozen_string_literal: true

# Used by Rodauth for rendering views, CSRF protection, and running any registered action callbacks and
# rescue_from handlers
class RodauthController < ApplicationController
  layout "authentication"
  before_action :verify_turnstile_captcha_login,
                only: :login,
                # Only runs this validation for the second phase of the login (when password is send)
                if: -> { request.post? && params[rodauth.password_param].present? }
  before_action :verify_turnstile_captcha,
                only: %i[create_account
                         verify_account_resend
                         reset_password_request],
                if: -> { request.post? }

  private

  def verify_turnstile_captcha
    return if Turnstile.siteverify(params["cf-turnstile-response"])

    flash[:alert] = t("failed_captcha_message")
    redirect_back_or_to "/"
  end
  alias verify_turnstile_captcha_login verify_turnstile_captcha
end
