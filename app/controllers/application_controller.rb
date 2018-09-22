# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ApiErrors::BaseError, with: :render_api_error

  private

  def render_api_error(error)
    render json: { errors: error.message }, status: error.code
  end
end
