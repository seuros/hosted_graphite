module HostedGraphite
  class TCP < Protocol
    private
      def build_message(name, value, timestamp = nil)
        if timestamp
          message = [name, value, timestamp].join(' ') + "\n"
        else
          message = [name, value].join(' ') + "\n"
        end

        [@api_key, message].join('.')
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
end
