require_relative 'helper'

class StatsDTest < Minitest::Test
  def setup
    HostedGraphite.protocol = 'statsd'
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
