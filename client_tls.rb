require 'socket'
require 'openssl'

class FakeClient
  attr_reader :server, :remote_addr

  def initialize(host, port)
    @server = Socket.new(:INET, :STREAM)
    @remote_addr = Socket.pack_sockaddr_in(port, host)
    @server.connect(@remote_addr)
  end

  def info
    [server, remote_addr]
  end

  def connect
    server.connect(remote_addr)
  end

  def close_write
    server.close_write
  end

  def send(message)
    server.write(message)
  end

  def read
    server.read
  end

  def recv(maxlen)
    server.recv(maxlen)
  end

end

def run
  if ARGV == []
    puts "\r\n============================="
    puts "Using default host and port: 0.0.0.0:4491"
    puts "Pass a host and port as arguments to connect to a different server."
    puts "Example: ruby client.rb 0.0.0.0:3000"
    puts "=============================\r\n\r\n"
  end
  server_host = ARGV[0] || "0.0.0.0" 
  server_port = ARGV[1] || 4491
  server, _ = FakeClient.new(server_host, server_port).info
  ssl_server = OpenSSL::SSL::SSLSocket.new(server)
  ssl_server.connect
  puts "Client has connected to #{server_host}:#{server_port}"
  ssl_server.syswrite("GET / HTTP/1.0\r\nhai!" )
  ssl_server.sysclose
  puts "Server says: #{ssl_server.sysread(100)}"
end

run
