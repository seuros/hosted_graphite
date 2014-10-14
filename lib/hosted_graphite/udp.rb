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
        Thread.current[:hostedgraphite_udpsocket] ||= UDPSocket.new addr_info.afamily
      end
  end
end
