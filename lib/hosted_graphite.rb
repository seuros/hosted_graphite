require 'forwardable'
require 'hosted_graphite/version'
require 'hosted_graphite/protocol'


module HostedGraphite
  extend Forwardable
  extend self
  attr_reader :namespace, :protocol
  attr_writer :namespace, :api_key

  def_delegators :protocol, :send_metric
  module_function :send_metric

  class MissingAPIKey < StandardError
    def initialize
      super('HOSTEDGRAPHITE_APIKEY is not set')
    end
  end

  def api_key
    @api_key ||= ENV['HOSTEDGRAPHITE_APIKEY']
  end

   def protocol=(protocol)
    protocol   = protocol.to_s.downcase
    require "hosted_graphite/protocols/#{protocol}"
    @protocol = @registred_protocols[protocol].new
   end

  @registred_protocols = {}
  private def register(name, klass)
    @registred_protocols[name] = klass
  end
end
