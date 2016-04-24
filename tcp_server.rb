require './lib/simple_server'
require 'thread'
require 'pry'
require 'pry-byebug'
require 'awesome_print'

Pry.config.editor = 'vim'

web_server = SimpleServer::Server.new.run
root_dir = SimpleServer::File.new(Dir.new('.'))
$logger = SimpleServer::Logger.new

loop do
  Thread.fork(web_server.accept) do |socket|
    env = SimpleServer::Env.new
    SimpleServer::Request.initialize(env, socket)

    unless env[:REQUEST_PATH] == '/favicon.ico'
      begin 
        base_dir = root_dir.check_path(env[:REQUEST_PATH])
        SimpleServer::Response.write_response(socket, base_dir)
      rescue Exception => e
        puts e
      end
    end

    socket.close
  end
end

