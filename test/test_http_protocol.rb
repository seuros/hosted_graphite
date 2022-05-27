# frozen_string_literal: true

require_relative 'helper'

class HTTPProtocolTest < Minitest::Test
  attr_reader :api_key

  def setup
    HostedGraphite.protocol = :http
  end

  def test_http_protocol
    assert_instance_of HostedGraphite::HTTP, HostedGraphite.protocol
  end

  def test_correct_query
    query = HostedGraphite.send_metric('foo', 1.2, 1_421_792_423)
    assert_equal 'foo 1.2 1421792423', query
  end
end
