module SimpleServer
  class Logger
    attr_reader :stdout, :stderr
    def initialize
      @stdout = STDOUT
      @stderr = STDERR
    end

    def put_log(str)
      @stdout.print(str)
    end

    def put_error(str)
      @stderr.print(str)
    end
  end
end
