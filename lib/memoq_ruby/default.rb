# frozen_string_literal: true

module MemoqRuby
  module Default
    # Default User Agent header string
    USER_AGENT = "memoq-ruby #{MemoqRuby::VERSION}"

    class << self
      # Configuration options
      # @return [Hash]
      def options
        MemoqRuby::Configurable.keys.to_h { |key| [key, send(key)] }
      end

      # Default memoQ username from ENV
      # @return [String]
      def username
        ENV.fetch('MEMOQ_USERNAME', "")
      end

      # Default memoQ password from ENV
      # @return [String]
      def password
        ENV.fetch('MEMOQ_PASSWORD', "")
      end

      # Default headers for Httparty
      # @return [Hash]
      def headers
        {
          "Content-Type" => "application/json",
          "Accept" => "application/json",
          "User-Agent" => user_agent
        }
      end

      # Default User-Agent header string from ENV or {USER_AGENT}
      # @return [String]
      def user_agent
        ENV.fetch('MEMOQ_USER_AGENT') { USER_AGENT }
      end

      # Default memoQ access token from ENV
      # @return [String]
      def access_token
        ENV.fetch('MEMOQ_ACCESS_TOKEN', "")
      end
    end
  end
end
