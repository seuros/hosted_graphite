require_relative 'helper'

class TCPProtocolTest < Minitest::Test
  attr_reader :api_key

  def setup
    HostedGraphite.protocol = 'tcp'
  end

  def test_tcp_protocol
    assert_instance_of HostedGraphite::TCP, HostedGraphite.protocol
  end

  def test_correct_query
    query = HostedGraphite.send_metric('foo', 1.2, 1421792423)
    assert_equal "#{HostedGraphite.api_key}.foo 1.2 1421792423\n", query
  end
end
