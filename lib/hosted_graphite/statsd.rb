gem 'statsd-ruby'
require 'hosted_graphite'
require 'statsd'

module HostedGraphite
  class StatsD < Statsd
    HOST = 'statsd.hostedgraphite.com'.freeze
    PORT = 8125.freeze

    def initialize
      raise MissingAPIKey unless HostedGraphite.api_key
      super(HOST, PORT)
      @namespace = HostedGraphite.api_key
      @prefix = "#{@namespace}."
    end

    private
    def socket
      Thread.current[:hostedstatsd_socket] ||= UDPSocket.new addr_family
    end

    def addr_family
      Addrinfo.udp(@host, @port).afamily
    end
  end

  @@statsd = StatsD.new

  class << self
    def increment(stat, sample_rate=1)
      @@statsd.increment stat, sample_rate
    end

    def decrement(stat, sample_rate=1)
      @@statsd.decrement stat, sample_rate
    end

    def count(stat, count, sample_rate=1)
      @@statsd.count stat, count, sample_rate
    end

    def gauge(stat, value, sample_rate=1)
      @@statsd.gauge stat, value, sample_rate
    end

    def set(stat, value, sample_rate=1)
      @@statsd.set stat, value, sample_rate
    end

    def timing(stat, ms, sample_rate=1)
      @@statsd.timing stat, ms, sample_rate
    end

    def time(stat, sample_rate=1, &blk)
      @@statsd.time stat, sample_rate, &blk
    end
  end
end
