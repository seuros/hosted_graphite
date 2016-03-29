require 'socket'
require 'net/http'
module HostedGraphite
  class Protocol
    HOST = 'carbon.hostedgraphite.com'.freeze
    API_URI = 'https://hostedgraphite.com/api/v1/sink'.freeze
    PORT = 2003.freeze

    def api_key
      HostedGraphite.api_key
    end

    def send_metric(name, value, timestamp = nil)
      raise MissingAPIKey unless api_key
      send_message(build_message(name, value, timestamp))
    rescue MissingAPIKey => e
      raise e
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
