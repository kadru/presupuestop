# frozen_string_literal: true

# Inherit from this controller to require authentication
class AuthenticatedController < ApplicationController
  before_action :authenticate
end
