module HostedGraphite
  class TCP < Protocol
    private
      def build_message(name, value, timestamp = nil)
        message = [name, value, timestamp].compact.join(' ') + "\n"
        [api_key, message].join('.')
      end

      def send_message(message)
        socket.puts(message)
        true
      end

      def socket
        Thread.current[:hostedgraphite_tcpsocket] ||= TCPSocket.new addr_info.ip_address,
                                                                    addr_info.ip_port
      end

      def addr_info
        Addrinfo.tcp(HOST, PORT)
      end
  end
  register('tcp', TCP)
end
