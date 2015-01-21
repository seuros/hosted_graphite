module HostedGraphite
  class UDP < Protocol
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
        socket.send(message, 0)
        true
      end

      def socket
        Thread.current[:hostedgraphite_udpsocket] ||= begin
          s = UDPSocket.new addr_info.afamily
          s.connect(addr_info.ip_address, addr_info.ip_port)
          s
        end
      end

      def addr_info
        Addrinfo.udp(HOST, PORT)
      end
  end
end
