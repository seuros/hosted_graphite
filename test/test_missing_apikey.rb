# frozen_string_literal: true

require_relative 'helper'

class MissingAPIKeyTest < Minitest::Test
  def setup
    @previous_api_key = HostedGraphite.api_key
    HostedGraphite.api_key = nil
  end

  def teardown
    HostedGraphite.api_key = @previous_api_key
  end

  def test_udp_protocol
    assert_raises HostedGraphite::MissingAPIKey do
      HostedGraphite::UDP.new.send_metric('foo', 1)
    end
  end

  def test_tcp_protocol
    assert_raises HostedGraphite::MissingAPIKey do
      HostedGraphite::TCP.new.send_metric('foo', 1)
    end
  end

  def test_http_protocol
    assert_raises HostedGraphite::MissingAPIKey do
      HostedGraphite::HTTP.new.send_metric('foo', 1)
    end
  end
end
