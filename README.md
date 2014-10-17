[![Build Status](https://travis-ci.org/seuros/hosted_graphite.svg?branch=master)](https://travis-ci.org/seuros/hosted_graphite)
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

```bash
HostedGraphite.api_key = 'YOUR API KEY'
```

#### Sending a metric via UDP
```ruby
HostedGraphite.protocol = HostedGraphite::UDP
HostedGraphite.send_metric('foo.udp', 1.2)
```

#### Sending a metric via TCP
```ruby
HostedGraphite.protocol = HostedGraphite::TCP
HostedGraphite.send_metric('foo.tcp', 1.2)
```

#### Sending a metric via HTTP
```ruby
HostedGraphite.protocol = HostedGraphite::HTTP
HostedGraphite.send_metric('foo.http', 1.2)
```

### HostedStatsD

Enable Statsd on your [account](https://www.hostedgraphite.com/app/data-sources)

Ensure these line are present in your application's Gemfile:

```ruby
gem 'hosted_graphite'
gem 'statsd-ruby'
```

And then require

```ruby
require 'hosted_graphite/statsd'
```

#### Basic usage

```ruby
# Send some stats
HostedGraphite.increment 'page_views'
HostedGraphite.decrement 'likes_count'
HostedGraphite.timing 'foo', 320
HostedGraphite.gauge 'bar', 100

# Use {#time} to time the execution of a block
HostedGraphite.time('newsletter.monthly') { @newletter.deliver_now }
```

## Contributing

1. Fork it ( https://github.com/seuros/hosted_graphite/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
