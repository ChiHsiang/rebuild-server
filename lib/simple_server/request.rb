require 'uri'

module SimpleServer
  module Request
    attr_accessor :env

    def self.initialize(env, socket)
      @env = env
      read_request(socket)
    end

    def self.read_request(socket)
      @env[:REMOTE_ADDR] = socket.remote_address.ip_address
      parse_request(socket.readline("\r\n"))
      while line = socket.readline("\r\n")
        break if line == "\r\n"
        @env[:HEADER][line.chop.split(":")[0]] = line.chop.split(":")[1].strip
      end
    end

    def self.parse_request(request_uri)
      request = request_uri.chop.split(" ")
      parse_uri(request[1])
      @env[:HTTP_METHOD] = request[0]
      @env[:HTTP_VERSION] = request[2]
    end

    def self.parse_uri(uri)
      uri = URI.parse(uri)
      @env[:REQUEST_PATH] = uri.path
      @env[:QUERY_STRING] = uri.query
    end

  end
end
