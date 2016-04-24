require './lib/simple_server'
require 'thread'
require 'pry'
require 'pry-byebug'
require 'awesome_print'

Pry.config.editor = 'vim'

$logger = SimpleServer::Logger.new
web_server = SimpleServer::Server.new.run
root_dir = SimpleServer::File.new(Dir.new('.'))

loop do
  Thread.fork(web_server.accept) do |socket|
    begin 
      env = SimpleServer::Env.new
      SimpleServer::Request.initialize(env, socket)

      unless env[:REQUEST_PATH] == '/favicon.ico'
        base_dir = root_dir.check_path(env[:REQUEST_PATH])
        SimpleServer::Response.write_response(socket, base_dir)
      else
        SimpleServer::Response.write_favicon(socket)
      end
    rescue Exception => e
      $logger.put_err("Error: #{e}")
    end

    socket.close
  end
end

