# frozen_string_literal: true

require "memoq_ruby/configurable"
require "httparty"
require "json"

module MemoqRuby
  class Client
    include MemoqRuby::Configurable

    include HTTParty
    base_uri 'https://memoq.act-uebersetzungen.com:8081/memoqserverhttpapi/v1'

    def initialize(options = {})
      MemoqRuby::Configurable.keys.each do |key|
        # rubocop:enable Style/HashEachMethods
        value = options[key].nil? ? MemoqRuby::Configurable.instance_variable_get(:"@#{key}") : options[key]
        instance_variable_set(:"@#{key}", value)
      end

      authenticate unless authenticated?
    end

    def authenticate
      response = self.class.post('/auth/login', body: {
        username: @username,
        password: @password
      }.to_json, headers:@headers)

      if response.success?
        @access_token = response.parsed_response["AccessToken"]
        @headers["Authorization"] = "MQS-API #{@access_token}"
      else
        raise "MemoQ Authentication failed: #{response.body}"
      end
    end

    # Indicates if the client was supplied an OAuth
    # access token
    #
    # @see https://developer.github.com/v3/#authentication
    # @return [Boolean]
    def authenticated?
      !@access_token.to_s.empty?
    end
  end
end
