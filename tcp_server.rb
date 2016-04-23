require './lib/simple_server'
require 'thread'
require 'pry'
require 'pry-byebug'
require 'awesome_print'

Pry.config.editor = 'vim'

web_server = SimpleServer::Server.new.run
base_dir = SimpleServer::File.new(Dir.new('.'))
$logger = SimpleServer::Logger.new

loop do
  Thread.fork(web_server.accept) do |socket|
    env = SimpleServer::Env.new
    SimpleServer::Request.initialize(env, socket)
    ap base_dir.check_path(env[:REQUEST_PATH])
    socket.close
  end
end

