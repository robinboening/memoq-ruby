# frozen_string_literal: true

require "memoq_ruby/default"

module MemoqRuby
  module Configurable
    attr_accessor :username, :user_agent, :headers
    attr_writer :password, :access_token

    class << self
      def keys
        @keys ||= %i[
          username
          password
          access_token
          user_agent
          headers
        ]
      end
    end

    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      # rubocop:disable Style/HashEachMethods
      #
      # This may look like a `.keys.each` which should be replaced with `#each_key`, but
      # this doesn't actually work, since `#keys` is just a method we've defined ourselves.
      # The class doesn't fulfill the whole `Enumerable` contract.
      MemoqRuby::Configurable.keys.each do |key|
        # rubocop:enable Style/HashEachMethods
        instance_variable_set(:"@#{key}", MemoqRuby::Default.options[key])
      end
      self
    end
    alias setup reset!

    def options
      MemoqRuby::Configurable.keys.to_h { |key| [key, instance_variable_get(:"@#{key}")] }
    end
  end
end
