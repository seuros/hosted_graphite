require 'forwardable'
require 'hosted_graphite/version'
require 'hosted_graphite/protocol'


module HostedGraphite
  extend Forwardable
  extend self

  attr_reader :namespace, :enabled, :protocol
  attr_writer :namespace, :enabled, :api_key

  class MissingAPIKey < StandardError
    def initialize
      super('HOSTEDGRAPHITE_APIKEY is not set')
    end
  end

  def api_key
    @api_key ||= ENV['HOSTEDGRAPHITE_APIKEY']
  end

  def enabled?
    @enabled.nil? ? true : @enabled
  end

  def send_metric(*args)
    protocol.send_metric(*args) if enabled?
  end
  module_function :send_metric

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
