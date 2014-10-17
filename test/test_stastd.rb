require_relative 'helper'

class StatsDTest < Minitest::Test
  def setup
    @previous_api_key = HostedGraphite.api_key
    HostedGraphite.api_key = SecureRandom.uuid
    require 'hosted_graphite/statsd'
  end

  def teardown
    HostedGraphite.api_key = @previous_api_key
  end

  def test_respond_to_time
    assert_respond_to HostedGraphite, :time
  end

  def test_respond_to_timing
    assert_respond_to HostedGraphite, :timing
  end

  def test_respond_to_set
    assert_respond_to HostedGraphite, :set
  end

  def test_respond_to_gauge
    assert_respond_to HostedGraphite, :gauge
  end

  def test_respond_to_decrement
    assert_respond_to HostedGraphite, :decrement
  end

  def test_respond_to_increment
    assert_respond_to HostedGraphite, :increment
  end
end
