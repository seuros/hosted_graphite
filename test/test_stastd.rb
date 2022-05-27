# frozen_string_literal: true

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

  def test_initialize_without_namespace
    old_namespace = HostedGraphite.namespace
    HostedGraphite.namespace = nil

    assert_equal HostedGraphite.api_key, HostedGraphite::STATSD.new.namespace

    HostedGraphite.namespace = old_namespace
  end

  def test_initialize_with
    old_namespace = HostedGraphite.namespace
    HostedGraphite.namespace = 'foo'

    assert_equal "#{HostedGraphite.api_key}.foo", HostedGraphite::STATSD.new.namespace

    HostedGraphite.namespace = old_namespace
  end
end
