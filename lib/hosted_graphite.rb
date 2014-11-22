require 'forwardable'
require 'hosted_graphite/version'
require 'hosted_graphite/protocol'
require 'hosted_graphite/udp'
require 'hosted_graphite/tcp'
require 'hosted_graphite/http'

module HostedGraphite
  extend Forwardable
  def_delegators :protocol, :send_metric
  module_function :send_metric
  @@api_key = ENV['HOSTEDGRAPHITE_APIKEY']
  @@protocol = nil

  class MissingAPIKey < StandardError
    def initialize
      super('HOSTEDGRAPHITE_APIKEY is not set')
    end
  end

  class << self
    def api_key
      @@api_key
    end

    def api_key=(key)
      @@api_key = key
    end

    def protocol
      @@protocol
    end

    def protocol=(protocol)
      # TODO, accept symbols and string (:udp, 'tcp')
      @@protocol = protocol.new
    end
  end
end
