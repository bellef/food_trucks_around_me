module CustomErrors
  module Api
    class BaseError < StandardError
      attr_reader :code, :message

      def initialize(code:, message:)
        @code = code
        @message = message
      end
    end
  end
end
