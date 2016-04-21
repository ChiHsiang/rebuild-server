require './lib/simple_server'
require 'thread'
require 'pry'
require 'pry-byebug'
require 'awesome_print'

web_server = SimpleServer::Server.new.run
$logger = SimpleServer::Logger.new

loop do
  Thread.fork(web_server.accept) do |socket|
    env = SimpleServer::Env.new
    SimpleServer::Request.initialize(env, socket)
    ap env
    socket.close
  end
end

