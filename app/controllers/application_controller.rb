# frozen_string_literal: true

# Main application controller, define here methods to inherit to all sub controllers
class ApplicationController < ActionController::Base
  private

  # @return [Account]
  def current_account
    rodauth.rails_account
  end

  def authenticate
    rodauth.require_account # redirect to login page if not authenticated
  end
end
