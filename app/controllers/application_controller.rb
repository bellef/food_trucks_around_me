# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from CustomErrors::Api::BaseError, with: :render_api_error
  rescue_from CustomErrors::Api::ThirdPartyApiError, with: :third_party_api_error
  # TODO: Rescue everything to render a custom 500 and send a rollbar
  # Please contact the system administrator of the service

  private

  def render_api_error(error)
    render json: { errors: error.message }, status: error.code
  end

  def third_party_api_error(error)
    render_api_error(error)
    # TODO
    puts "ROLLBAR HERE" if error.code == 500
  end
end
