gem 'sidekiq', '>=  4.1.1'
require 'sidekiq'

module HostedGraphite
  module Ext
    module Sidekiq
      class Metrics
        def initialize(namespace:)
          @client = HostedGraphite
          @namespace = namespace
        end

        def call(worker, msg, _, &block)
          w = msg['wrapped'] || worker.class.to_s
          w = [@namespace,'jobs', w].compact.join('.')
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
        def initialize(namespace:)
          super
          require 'hosted_graphite/statsd'
          @client = StatsD.new
        end
      end
    end
  end
end
