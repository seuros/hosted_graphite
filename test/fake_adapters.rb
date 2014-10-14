# TODO: Remove this hack and use fake adapters
module HostedGraphite
  [TCP, UDP, HTTP].each do |protocol|
    protocol.class_eval do

      private

      def send_message(message)
        message
      end
    end
  end
end
