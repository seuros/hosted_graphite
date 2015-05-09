require 'forwardable'
require 'hosted_graphite/version'
require 'hosted_graphite/protocol'
require 'hosted_graphite/udp'
require 'hosted_graphite/tcp'
require 'hosted_graphite/http'

module HostedGraphite
  extend Forwardable
  extend self

  def_delegators :protocol, :send_metric
  module_function :send_metric
  @protocol = nil

  class MissingAPIKey < StandardError
    def initialize
      super('HOSTEDGRAPHITE_APIKEY is not set')
    end
  end

  def api_key
    @api_key ||= ENV['HOSTEDGRAPHITE_APIKEY']
  end

  def api_key=(key)
    @api_key = key
  end

  def protocol
    @protocol
  end

  def protocol=(protocol)
    case protocol
      when Class
        @protocol = protocol.new
      when String, Symbol
        protocol   = protocol.to_s.upcase
        @protocol = const_get(protocol).new
    end
  end
end
