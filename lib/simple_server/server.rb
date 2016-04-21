require 'socket'

module SimpleServer
  class Server
    attr_accessor :host, :port

    def initialize(options = {})
      @host = options[:host] || '127.0.0.1'
      @port = options[:port] || 3000
    end

    def run 
      TCPServer.new(@host, @port)
    end
  end
end
