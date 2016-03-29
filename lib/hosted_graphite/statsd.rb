gem 'statsd-ruby'
require 'hosted_graphite'
require 'statsd'

module HostedGraphite
  def_delegators :statsd, :increment, :decrement, :count, :gauge, :set, :timing, :time

  class StatsD < Statsd
    HOST = 'statsd.hostedgraphite.com'.freeze
    PORT = 8125.freeze

    def initialize
      raise MissingAPIKey unless HostedGraphite.api_key
      super(HOST, PORT)
      @namespace = HostedGraphite.api_key
      @prefix    = "#{@namespace}."
    end

    private
    def socket
      Thread.current[:hostedstatsd_socket] ||= UDPSocket.new addr_family
    end

    def addr_family
      Addrinfo.udp(@host, @port).afamily
    end
  end

  def statsd
    @statsd ||= StatsD.new
  end

end
