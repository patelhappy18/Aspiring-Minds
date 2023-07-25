import 'package:aspirant_minds/bottom_bar/custom_bottom_bar.dart';
import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  Chat(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<Chat> createState() {
    return _Chat();
  }
}

enum BottomBarEnum {
  Homeicon,
  Messageicon,
  Purchaseicon,
  Profileicon,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.type,
    this.isPng = false,
  });

  Icon icon;

  BottomBarEnum type;

  bool isPng;
}

class _Chat extends State<Chat> {
  String userName = "";
  String chatId = "";
  String? currentUserId = "";
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];
  List<dynamic> sendersList = [];
  @override
  void initState() {
    super.initState();
    getUserName();
    loadAllMessages();

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

  void loadAllMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sendersListJson = prefs.getString('sendersList');
    String? userId = prefs.getString('user_id');
    setState(() {
      currentUserId = userId;
    });

    if (sendersListJson != null) {
      sendersList = json.decode(sendersListJson);
      // Use the sendersList data as needed in your app
    }

    // Retrieve messageContents from SharedPreferences
    String? messageContentsJson = prefs.getString('messageContents');
    if (messageContentsJson != null) {
      List<dynamic> messageContentsData = json.decode(messageContentsJson);
      setState(() {
        messages = messageContentsData;
      });
      print("messages  : $messages");
    }
  }

  void demo(String s) {}

  void _sendMessage(String message) async {
    String apiUrl = 'http://localhost:8000/msg/messages';
    print("sent msg");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = {
      'senderId': currentUserId,
      'receiverId': chatId,
      "content": message
    };

    http.Response response = await http.post(Uri.parse(apiUrl), body: data);
    final jsonResponse = json.decode(response.body);
    print("outside 200");
    if (response.statusCode == 200) {
      // sendersList = List<Map<String, dynamic>>.from(jsonResponse['responseData']);
      List messagesData = jsonResponse['message'];
      print("=======> messagesData : $jsonResponse");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String messageContentsJson = json.encode(jsonResponse['message']);
      prefs.setString('messageContents', messageContentsJson);
      setState(() {
        messages = jsonResponse['message'];
      });
      _textController.clear();
      print("messages  : $messages");
    } else {
      // Error response from the backend
      print('Request failed with status: ${response.statusCode}');
    }

    // Send a message to the server

    // IO.Socket socket = IO.io('http://localhost:8000/messages');
    // socket.emit('message',
    //     {'sender_user_id': prefs.getString('user_id'), 'message': message});
    // _messageController.clear();
    // if (message.isNotEmpty) {
    //   setState(() {
    //     messages.insert(
    //         0, message); // Add new message to the beginning of the list
    //   });
    //   _textController
    //       .clear(); // Clear the input field after sending the message
    // }
  }

  void onBtnPress() {
    widget.switchScreen("chat_list");
  }

  Future<void> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var chatDetails = json.decode(prefs.getString('chat') ?? "");
    var user_id = prefs.getString('user_id');

    setState(() {
      userName = chatDetails["name"];
      chatId = chatDetails["id"].toString();
      currentUserId = user_id;
    });
    // Do something with the user's email...
  }

  List<dynamic> messages = [];

  // Controller for the message input TextField
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(
                        const Icon(
                          Icons.arrow_left_outlined,
                          size: 40,
                          color: Color.fromRGBO(240, 130, 0, 1),
                        ),
                        onClick: onBtnPress,
                      ),
                      Text(
                        userName ?? "John Wick",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                      Image.asset(
                        'assets/images/profile_big.png',
                        height: 70,
                        width: 70,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      // reverse: true, // Start from the bottom
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        // Access the content of each message from the messages list
                        String content = messages[index]["content"];
                        DateTime dateTime =
                            DateTime.parse(messages[index]['timestamp']);

                        // Convert the DateTime to TimeOfDay
                        TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
                        String formattedTime =
                            '${timeOfDay.hour}:${timeOfDay.minute}';

                        return messages[index]['sender'] != currentUserId
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 3,
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        top: 4,
                                        right: 8,
                                        bottom: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 218, 216, 216),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 6,
                                              top: 2,
                                              bottom: 3,
                                            ),
                                            child: Text(
                                              content,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 0.75,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              top: 12,
                                            ),
                                            child: Text(
                                              formattedTime,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 3,
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        top: 4,
                                        right: 8,
                                        bottom: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            240, 130, 0, 1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 6,
                                              top: 2,
                                              bottom: 3,
                                            ),
                                            child: Text(
                                              content,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 0.75,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 20,
                                              top: 12,
                                            ),
                                            child: Text(
                                              formattedTime,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                  const Divider(height: 1.5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _buildTextComposer(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextBox(
            innerTxt: 'Send a message',
            customController: _textController,
            onSubmitted: demo,
            // onSubmitted: _sendMessage,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(240, 130, 0, 1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.send),
            // onPressed: () => {},
            onPressed: () => _sendMessage(_textController.text),
          ),
        ),
      ],
    );
  }
}
