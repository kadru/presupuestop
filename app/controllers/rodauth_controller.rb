# frozen_string_literal: true

# Used by Rodauth for rendering views, CSRF protection, and running any registered action callbacks and
# rescue_from handlers
class RodauthController < ApplicationController
  layout "authentication"
  before_action :verify_turnstile_captcha,
                only: :login,
                # Only runs this validation for the second phase of the login (when password is send)
                if: -> { request.post? && params[rodauth.password_param].present? }

  def verify_turnstile_captcha
    return if Turnstile.siteverify(params["cf-turnstile-response"])

    flash[:alert] = t("failed_captcha_message")
    redirect_to rodauth.login_path
  end
end
