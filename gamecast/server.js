var express = require('express');
var app = express.createServer();
var io = require('socket.io').listen(app);
var net = require('net');
var events = require('events');

var actionEmitter = new events.EventEmitter();

app.configure('development', function(){
	app.use(express.static(__dirname + '/public'));
});

var tcp = net.createServer(function(socket){
	socket.setEncoding('ascii');
	socket.on('connect', function(){
		console.log("connection to event server made.");
	});
	
	socket.on('data', function(data){
		console.log(data)
		var object = JSON.parse(data);
		actionEmitter.emit('action', object);
	});
});

tcp.listen(1337, "localhost");
app.listen(3000);

io.sockets.on('connection', function(socket){
	actionEmitter.on('action', function(data){
		socket.emit(data.type, data.value);
	});
});
