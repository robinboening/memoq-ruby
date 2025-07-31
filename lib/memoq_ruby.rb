require "memoq_ruby/version"
require "memoq_ruby/client"

module MemoqRuby
  class << self
    include MemoqRuby::Configurable

    def client
      return @client if defined?(@client)

      @client = MemoqRuby::Client.new(options)
    end
  end
end

MemoqRuby.setup
