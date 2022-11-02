require 'socket'

class Client
  attr_reader :client, :remote_addr

  def initialize(host, port)
    @client = Socket.new(:INET, :STREAM)
    @remote_addr = Socket.pack_sockaddr_in(port, host)
  end

  def connect
    client.connect(remote_addr)
  end

  def close_write
    client.close_write
  end

  def send(message)
    client.write(message)
  end

  def read
    client.read
  end

  def recv(maxlen)
    client.recv(maxlen)
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
  client = Client.new(server_host, server_port)
  client.connect
  puts "Client has connected to #{server_host}:#{server_port}"
  client.send("GET / HTTP/1.0\r\nhai!" )
  client.close_write
  puts "\nServer says: \n#{client.recv(100)}"
end

run