require_relative 'helper'

class UDPProtocolTest < Minitest::Test
  attr_reader :api_key
  def setup
    @previous_api_key = HostedGraphite.api_key
    @api_key = SecureRandom.uuid
    HostedGraphite.api_key = @api_key
    HostedGraphite.protocol = HostedGraphite::UDP
  end

  def teardown
    HostedGraphite.api_key = @previous_api_key
  end

  def test_correct_query
    query = HostedGraphite.send_metric('foo', 1.2, 1421792423)
    assert_equal "#{api_key}.foo 1.2 1421792423\n", query
  end
end
