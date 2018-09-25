# frozen_string_literal: true

require 'rollbar'

Rollbar.configure do |config|
  # Disable for non production environments
  config.enabled = false unless Rails.env.production?
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
end
