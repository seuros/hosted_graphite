require_relative 'helper'
require_relative 'fake_adapters'

class TCPProtocolTest < Minitest::Test
  attr_reader :api_key
  def setup
    @previous_api_key = HostedGraphite.api_key
    @api_key = SecureRandom.uuid
    HostedGraphite.api_key = @api_key
    HostedGraphite.protocol = HostedGraphite::TCP
  end

  def teardown
    HostedGraphite.api_key = @previous_api_key
  end

  def test_correct_query
    query = HostedGraphite.send_metric('foo', 1.2)
    assert_equal "#{api_key}.foo 1.2\n", query
  end
end
