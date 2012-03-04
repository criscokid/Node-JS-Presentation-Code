var net = require('net');

var server = net.createServer(function(socket){
	socket.setEncoding('ascii');
	
	socket.on('connect', function(){
		console.log("connected");
	});
	
	socket.on('data', function(data){
		console.log(data);
	});
});

server.listen(1337, "localhost");