# frozen_string_literal: true

# Encapsulates access to app configuration
class Config
  def self.categories
    Rails.application.config_for(:categories)
  end
end
