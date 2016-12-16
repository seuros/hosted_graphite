require_relative 'helper'

class DefaultBehaviourTest < Minitest::Test
  def setup
    HostedGraphite.protocol = :http
  end

  def test_enabled_by_default
    assert_equal true, HostedGraphite.enabled?
  end

  def test_send_by_default
    assert_send [HostedGraphite.protocol, :send_metric, *['foo', 1.2]]
    HostedGraphite.send_metric 'foo', 1.2
  end
end


class DisabledTest < Minitest::Test
  def setup
    @previous_api_key = HostedGraphite.api_key
    HostedGraphite.api_key = nil
    HostedGraphite.enabled = false
  end

  def teardown
    HostedGraphite.enabled = nil
    HostedGraphite.api_key = @previous_api_key
  end

  def test_metric_send
    # Will raise HostedGraphite::MissingAPIKey if incorrect
    HostedGraphite.send_metric 'foo', 1.2
  end
end
