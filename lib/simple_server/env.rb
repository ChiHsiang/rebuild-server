module SimpleServer
  class Env
    def self.new 
      env = ENV.to_hash
      env.update(
        QUERY_STRING: '', 
        HTTP_METHOD: '',
        HTTP_VERSION: '',
        REQUEST_PATH: '',
        REMOTE_ADDR: '',
        HEADER: {}
      )
      return env
    end
  end
end
