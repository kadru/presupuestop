# frozen_string_literal: true

# show profile for current logged account
class ProfileController < ApplicationController
  before_action :authenticate

  def show; end
end
