require './lib/simple_server/body'

module SimpleServer
  module Response
    HTTP_VERSION = '1.1'

    HTTP_STATUSES = {
      # 1xx
      100 => 'Continue',
      101 => 'Switching Protocols',
      102 => 'Processing',
      # 2xx
      200 => 'OK',
      201 => 'Created',
      202 => 'Accepted',
      203 => 'Non-Authoritative Information',
      204 => 'No Content',
      205 => 'Reset Content',
      206 => 'Partial Content',
      # 3xx
      300 => 'Multiple Choices',
      301 => 'Moved Permanently',
      302 => 'Found',
      303 => 'See Other',
      304 => 'Not Modified',
      305 => 'Use Proxy',
      307 => 'Temporary Redirect',
      # 4xx
      400 => 'Bad Request',
      401 => 'Unauthorized',
      402 => 'Payment Required',
      403 => 'Forbidden',
      404 => 'Not Found',
      405 => 'Method Not Allowed',
      406 => 'Not Acceptable',
      407 => 'Proxy Authentication Required',
      408 => 'Request Time-out',
      409 => 'Conflict',
      410 => 'Gone',
      411 => 'Length Required',
      412 => 'Precondition Failed',
      413 => 'Request Entity Too Large',
      414 => 'Request-URI Too Large',
      415 => 'Unsupported Media Type',
      416 => 'Requested range not satisfiable',
      417 => 'Expectation Failed',
      # 5xx
      500 => 'Internal Server Error',
      501 => 'Not Implemented',
      502 => 'Bad Gateway',
      503 => 'Service Unavailable',
      504 => 'Gateway Time-out',
      505 => 'HTTP Version not supported extension-code'
    }

    # Generic Bad Request response
    BAD_REQUEST = [400, {}, ['Bad Request']]
        
    def self.write_status(status)
      status = status.to_i
      reason = HTTP_STATUSES[status]
      return "HTTP/#{HTTP_VERSION} #{status} #{reason}\r\n"
    end

    def self.write_header(length)
      header = "Content-Type: text/html\r\n" +
               "Content-Length: #{length}\r\n" +
               "Connection: close\r\n"
      header
    end

    def self.write_body(base_dir)
      body = SimpleServer::Body.new
      body.render_node(base_dir)
    end

    def self.write_response(socket, base_dir)
      body = write_body(base_dir)

      socket.write(write_status(200))
      socket.write(write_header(body.size))
      socket.write("\r\n")
      socket.write(body)
    end

  end
end
