gem 'statsd-ruby'
require 'hosted_graphite'
require 'statsd'

module HostedGraphite
  def_delegators :statsd, :increment, :decrement, :count, :gauge, :set, :timing, :time

  class STATSD < Statsd
    HOST = 'statsd.hostedgraphite.com'.freeze
    PORT = 8125.freeze

    def initialize
      raise MissingAPIKey unless HostedGraphite.api_key
      super(HOST, PORT)
      self.namespace = [HostedGraphite.api_key,HostedGraphite.namespace].join('.')
    end
  end

  def statsd
    @statsd ||= STATSD.new
  end

  register('statsd', STATSD)
end
