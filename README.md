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

### Sending a metric via UDP
```ruby
HostedGraphite.protocol = HostedGraphite::UDP
HostedGraphite.send_metric('foo.udp', 1.2)
```

### Sending a metric via TCP
```ruby
HostedGraphite.protocol = HostedGraphite::TCP
HostedGraphite.send_metric('foo.tcp', 1.2)
```

### Sending a metric via HTTP
```ruby
HostedGraphite.protocol = HostedGraphite::HTTP
HostedGraphite.send_metric('foo.http', 1.2)
```

## Contributing

1. Fork it ( https://github.com/seuros/hosted_graphite/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
