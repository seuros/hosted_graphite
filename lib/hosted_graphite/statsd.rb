gem 'statsd-ruby'
require 'hosted_graphite'
require 'statsd'

module HostedGraphite
  class StatsD < Statsd
    HOST = '78.46.93.167'.freeze
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
      unless HostedGraphite.debug?
        @@statsd.increment stat, sample_rate
      end
    end

    def decrement(stat, sample_rate=1)
      unless HostedGraphite.debug?
        @@statsd.decrement stat, sample_rate
      end
    end

    def count(stat, count, sample_rate=1)
      unless HostedGraphite.debug?
        @@statsd.count stat, count, sample_rate
      end
    end

    def gauge(stat, value, sample_rate=1)
      unless HostedGraphite.debug?
        @@statsd.gauge stat, value, sample_rate
      end
    end

    def set(stat, value, sample_rate=1)
      unless HostedGraphite.debug?
        @@statsd.set stat, value, sample_rate
      end
    end

    def timing(stat, ms, sample_rate=1)
      unless HostedGraphite.debug?
        @@statsd.timing stat, ms, sample_rate
      end
    end

    def time(stat, sample_rate=1, &blk)
      unless HostedGraphite.debug?
        @@statsd.time stat, sample_rate, &blk
      else
        yield
      end
    end
  end
end
