module CustomErrors
  module Api
    class ThirdPartyApiError < CustomErrors::Api::BaseError
      attr_reader :data

      def initialize(code:, message:, data:)
        @data = data
        super(code: code, message: message)
      end
    end
  end
end
