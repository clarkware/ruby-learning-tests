#!/usr/bin/env ruby

require 'test/unit'

require 'socket'

class SocketTest < Test::Unit::TestCase

  def test_socket
    
    Thread.new() do
      server = TCPServer.new('localhost', 7777)
      session = server.accept
      assert_equal("Ping\n", session.gets)
      session.print("Pong\n")
      session.close()
    end
    
    attempts = 0
    begin
      attempts += 1 
      client = TCPSocket.open('localhost', 7777)
      client.send("Ping\n", 0)
      assert_equal("Pong\n", client.gets)
      client.close
    rescue
      retry if attempts < 2
    end 
    
  end

end
