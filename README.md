# Echo Server in Ruby

Simple echo server in Ruby. Returns request data to response. Useful for testing.

## Usage

Boot the server
```bash
chmod +x bin/*
./bin/server
```

Connect to the server through client
```bash
./bin/client
```

Alternatively, you can use netcat
```bash
echo "HTTP/1.1 200 OK\r\n\r\n" | nc 0.0.0.0 4491
```
