# frozen_string_literal: true

require 'hosted_graphite'
require 'securerandom'
require 'hosted_graphite/protocols/http'
require 'hosted_graphite/protocols/tcp'
require 'hosted_graphite/protocols/udp'
module HostedGraphite
  @api_key = SecureRandom.hex
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
    alias increment testing
    alias decrement testing
    alias count testing
    alias gauge testing
    alias set testing
    alias timing testing
    alias time testing
  end
end
