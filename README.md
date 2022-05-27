[![Build status](https://github.com/seuros/hosted_graphite/actions/workflows/ci.yml/badge.svg)](https://github.com/seuros/hosted_graphite/actions/workflows/ci.yml)
[![Code Climate](https://codeclimate.com/github/seuros/hosted_graphite/badges/gpa.svg)](https://codeclimate.com/github/seuros/hosted_graphite)

# HostedGraphite

A Ruby client for HostedGraphite

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hosted_graphite'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install hosted_graphite
```

## Usage

Set ```ENV['HOSTEDGRAPHITE_APIKEY']```  to your hosted graphite API key.
Your API key can be found on your [account home](https://www.hostedgraphite.com/accounts/profile/) page.

You can also set the hosted graphite API key programatically with:

```ruby
HostedGraphite.api_key = 'YOUR API KEY'
```

You may also specify a namespace for your metrics, which will be applied if you are using the StatsD backend:

```bash
HostedGraphite.namespace = 'our_app'
```

#### Sending a metric via UDP
```ruby
HostedGraphite.protocol = :udp
HostedGraphite.send_metric('foo.udp', 1.2)
```

#### Sending a metric via TCP
```ruby
HostedGraphite.protocol = :tcp
HostedGraphite.send_metric('foo.tcp', 1.2)
```

#### Sending a metric via HTTP
```ruby
HostedGraphite.protocol = :http
HostedGraphite.send_metric('foo.http', 1.2)
```

### HostedStatsD

Enable Statsd on your [account](https://www.hostedgraphite.com/app/data-sources)

Ensure these line are present in your application's Gemfile:

```ruby
gem 'hosted_graphite'
gem 'statsd-ruby'
```

#### Basic usage

```ruby
HostedGraphite.protocol = :statsd
# Send some stats
HostedGraphite.increment 'page_views'
HostedGraphite.decrement 'likes_count'
HostedGraphite.timing 'foo', 320
HostedGraphite.gauge 'bar', 100

# Use {#time} to time the execution of a block
HostedGraphite.time('newsletter.monthly') { @newsletter.deliver_now }
```

### Extensions
#### Sidekiq
```ruby
require 'hosted_graphite/ext/sidekiq'

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    # my_app is an optional namespace
    # chain.prepend HostedGraphite::Ext::Sidekiq::StatsdMetrics, 'my_app'
    # or
    # chain.prepend HostedGraphite::Ext::Sidekiq::Metrics
  end
end
```

### Disable sends for local/test environments

```ruby
HostedGraphite.enabled = false unless Rails.env.production?
```

## Contributing

1. Fork it ( https://github.com/seuros/hosted_graphite/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
