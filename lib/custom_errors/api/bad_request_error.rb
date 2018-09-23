module CustomErrors
  module Api
    class BadRequestError < CustomErrors::Api::BaseError
      DEFAULT_BAD_REQUEST_MESSAGE = 'The server could not understand the request due to invalid syntax.'.freeze

      def initialize(code: 400, message: DEFAULT_BAD_REQUEST_MESSAGE)
        super
      end
    end
  end
end
