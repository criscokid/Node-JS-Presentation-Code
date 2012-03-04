require 'socket'

s = TCPSocket.open('localhost', 1337)
t = TCPSocket.open('localhost', 1337)
u = TCPSocket.open('localhost', 1337)
v = TCPSocket.open('localhost', 1337)

File.open("file.txt", "r") do |f|
  while (line = f.gets)
    s.print "s: #{line}"
    sleep(1)
    t.print "t: #{line}"
    sleep(1)
    u.print "u: #{line}"
    sleep(1)
    v.print "v: #{line}"
    sleep(1)
  end
end