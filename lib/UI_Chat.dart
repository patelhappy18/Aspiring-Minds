// chat_app.dart
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatApp extends StatefulWidget {
  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();

    // Connect to the Socket.IO server
    IO.Socket socket = IO.io('http://localhost:8000', <String, dynamic>{
      'transports': ['websocket'],
    });

    // Listen for incoming messages from the server
    socket.on('message', (data) {
      setState(() {
        _messages.add('${data['user']}: ${data['message']}');
      });
    });
  }

  void _sendMessage(String message) {
    // Send a message to the server
    IO.Socket socket = IO.io('http://localhost:8000/');
    socket.emit('message', {'user': 'User123', 'message': message});

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Your UI code goes here
    return Scaffold(
      appBar: AppBar(title: Text('Chat App')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
