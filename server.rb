require 'socket'

class FakeTCPServer
  attr_reader :server, :host, :port

  def initialize(host = "0.0.0.0", port = 4491)
    @server = Socket.new(:INET, :STREAM)
    @addr = Socket.pack_sockaddr_in(port, host)
    @server.bind(@addr)
    @host = host
    @port = port
  end

  def listen(backlog = 5)
    server.listen(backlog)
  end

  def accept
    client, addr = server.accept
    [client, addr]
  end

  def close(conn)
    conn.close
  end
end

def run
  server = FakeTCPServer.new
  server.listen
  puts "Server booted. Listening on port #{server.host}:#{server.port}"
  loop do
    client, addr = server.accept
    puts "Received connection from #{addr.ip_address}:#{addr.ip_port}\r\n"
    puts "\nClient says:\n#{client.recv(100)}"
    client.write("HTTP/1.0 200 OK\r\nHello World!\r")
    server.close(client)
  end
end

run