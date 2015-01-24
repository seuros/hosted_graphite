require 'hosted_graphite'
require 'securerandom'
module HostedGraphite
  @@api_key = SecureRandom.hex
  [TCP, UDP, HTTP].each do |protocol|
    protocol.class_eval do

      private

      def send_message(message)
        message
      end
    end
  end

  class << self
    def testing(*)
      yield if block_given?
    end
    alias_method :increment, :testing
    alias_method :decrement, :testing
    alias_method :count, :testing
    alias_method :gauge, :testing
    alias_method :set, :testing
    alias_method :timing, :testing
    alias_method :time, :testing
  end
end
