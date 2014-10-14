require 'socket'
module HostedGraphite
  class UDP < Protocol
    private
      def build_message(name, value)
        message = [name, value].join(' ') + "\n"
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
  end
end
