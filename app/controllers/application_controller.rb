# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from CustomErrors::Api::BaseError, with: :render_api_error
  rescue_from CustomErrors::Api::ThirdPartyApiError, with: :third_party_api_error
  rescue_from StandardError, with: :handle_server_error

  private

  def render_api_error(error)
    render json: { errors: error.message }, status: error.code
  end

  def third_party_api_error(error)
    render_api_error(error)
    Rollbar.error(error.message, error.data.instance_values.merge(code: error.data.code)) if error.code == 500
  end

  def handle_server_error(error)
    render json: { errors: 'An internal server error occured, please contact the service administrator or see the logs if you are the administrator.' }, status: 500
    Rollbar.error(error)
  end
end
