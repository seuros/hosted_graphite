# ANALYSE, is this implementation thread safe ?
module HostedGraphite
  class HTTP < Protocol
    def initialize
      super
      @uri = URI(API_URI)
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    def send_message(message)
      req = Net::HTTP::Post.new(@uri.request_uri)
      req.basic_auth api_key, nil
      req.body = message
      @http.request(req)
    end
  end
end
