# Server & Client Example

The purpose of this repository is to help instruct people on what servers and clients are through a code reading exercise.

## Usage

There are two files to run here, in two separate terminals:

```bash
# Terminal 1
# 0.0.0.0 is the host, 4491 is the port
ruby server.rb 0.0.0.0 4491
```

```bash
# Terminal 2
# connect to the 0.0.0.0:4491 address
ruby client.rb 0.0.0.0 4491
```

## Concepts to note

A server socket listens for connections rather than initiating them. The typical lifecycle looks something like this: 1) create, 2) bind, 3) listen, 4) accept, 5) close.

A client socket initiates a connection to a server socket. The typical lifecycle looks something like this: 1) create, 2) connect, 3) close.

## How to read the code

See how the concepts above are used in the code. I suggest logging through every line of code to see what is happening.

## TLS Versions

To see how TLS works, you can run the following command:

```bash
ruby server_tls.rb
```

It should boot up a server that requires a TLS connection. If you try to connect to it with `client.rb` (or even netcat with `nc 0.0.0.0 4491`) you will get an error. If you try to connect to it with `client_tls.rb`, it will work.

