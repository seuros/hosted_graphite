begin
  require 'byebug'
  require 'pry'
rescue LoadError
end
require 'securerandom'
require 'minitest/autorun'
require 'hosted_graphite/testing'

HostedGraphite.api_key = SecureRandom.uuid
