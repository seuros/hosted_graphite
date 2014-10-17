require 'socket'
require 'net/http'
module HostedGraphite
  class Protocol
    HOST = 'carbon.hostedgraphite.com'.freeze
    API_URI = 'https://hostedgraphite.com/api/v1/sink'.freeze
    PORT = 2003.freeze

    def initialize
      fail MissingAPIKey unless HostedGraphite.api_key
      @api_key = HostedGraphite.api_key
    end

    def send_metric(name, value)
      msg = build_message(name, value)
      send_message(msg)
    rescue => e
      # set HOSTEDGRAPHITE_DEBUG to to raise errors instead of silencing them.
      raise e if ENV['HOSTEDGRAPHITE_DEBUG']
      0
    end

    private
      def build_message(name, value)
        [name, value].join(' ')
      end
  end
end
