require 'rubygems'
require 'socket'
require 'json'

MIN = 0
MAX = 100

def put_on_socket(socket, value)
  socket.print value
  sleep(2)
end

s = TCPSocket.open('localhost', 1337)

while(true)
  startPoint = rand(30)
  nextFD = startPoint + 10
  currentDown = 1
  currentPoint = startPoint
  
  put_on_socket(s, { :type => 'setStart', :value => startPoint}.to_json) 
  put_on_socket(s, { :type => 'firstDown', :value => nextFD}.to_json)
  
  while(currentDown < 5)
    
    negative = rand(20)
    if(negative <= 7)
      play = rand(10) * -1
    else
      play = rand(25)
    end
    
    put_on_socket(s, { :type => 'play', :value => play}.to_json)
    
    if(currentPoint + play >= 100)
      put_on_socket(s, { :type => 'reset', :value => ''}.to_json)
      break
    end
    
    currentPoint = currentPoint + play
    
    if(currentPoint >= nextFD)
      nextFD = currentPoint + 10
      put_on_socket(s, { :type => 'firstDown', :value => nextFD}.to_json)
      currentDown = 1
      next
    end
    currentDown += 1
  end
  
  put_on_socket(s, { :type => 'reset', :value => ''}.to_json)
  
end