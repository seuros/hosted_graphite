gem 'sidekiq', '>=  4.1.2'
require 'sidekiq'

module HostedGraphite
  module Ext
    module Sidekiq
      class Metrics
        def initialize(namespace=nil)
          @client = HostedGraphite
          HostedGraphite.namespace = namespace
        end

        def call(worker, msg, _, &block)
          w = msg['wrapped'] || worker.class.to_s
          w = ['jobs', w].compact.join('.')
          begin
            @client.increment("#{w}.performed")
            @client.time("#{w}.time", &block)
            @client.increment("#{w}.succeed")
          rescue Exception
            @client.increment("#{w}.failed")
            raise
          end
        end
      end

      class StatsdMetrics < Metrics
        def initialize(namespace=nil)
          super
          require 'hosted_graphite/protocol/statsd'
          @client = STATSD.new
        end
      end
    end
  end
end
