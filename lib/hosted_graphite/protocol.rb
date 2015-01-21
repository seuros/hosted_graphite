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

    def send_metric(name, value, timestamp = nil)
      send_message(build_message(name, value, timestamp))
    rescue => e
      # set HOSTEDGRAPHITE_DEBUG to to raise errors instead of silencing them.
      raise e if ENV['HOSTEDGRAPHITE_DEBUG']
      0
    end

    private

    def build_message(name, value, timestamp = nil)
      unless timestamp
        return [name, value].join ' '
      end

      [name, value, timestamp].join ' '
    end
  end
end
