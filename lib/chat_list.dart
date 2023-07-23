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

class ChatList extends StatefulWidget {
  const ChatList(this.switchScreen, {super.key, required this.pageName});
  final String pageName;
  final void Function(String screenName) switchScreen;
  @override
  State<ChatList> createState() {
    return _ChatList();
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

class _ChatList extends State<ChatList> {
  List<Map<String, dynamic>> sendersList = [];
  List<String> messagesContent = [];

  List<String> chatUsers = [
    'User1',
    'User2',
    'User3'
  ]; // Replace with actual user data

  void onBtnPress() {
    widget.switchScreen("home");
  }

  void onSelectChat({String? name, String? id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      // Your API endpoint URL
      String apiUrl = 'http://localhost:8000/msg/getSpecificMessages';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = {
        'senderId': id,
        'receiverId': prefs.getString('user_id'),
      };
      // prefs.setString('receiverId',data['senderId']);

      // Make the POST request to your Node.js backend
      http.Response response = await http.post(Uri.parse(apiUrl), body: data);
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        // sendersList = List<Map<String, dynamic>>.from(jsonResponse['responseData']);
        List<dynamic> messagesData = jsonResponse['messages'];
        List<String> messageContents = List<String>.from(
            messagesData.map((message) => message['content']));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<dynamic> messageContentsData = messageContents.toList();
        String messageContentsJson = json.encode(messagesData);
        prefs.setString('messageContents', messageContentsJson);
        prefs.setString('chat', json.encode({"name": name, "id": id}));
      } else {
        // Error response from the backend
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during the API request
      print('Error: $e');
    }

    widget.switchScreen("chat");
  }

  @override
  void initState() {
    getChatList();
    super.initState();

    // Connect to the Socket.IO server
    IO.Socket socket = IO.io('http://localhost:8000', <String, dynamic>{
      'transports': ['websocket'],
    });

    // Listen for incoming messages from the server
    socket.on('chatList', (data) {
      setState(() {
        chatUsers = List<String>.from(data['users']);
      });
    });
  }

  void getChatList() async {
    try {
      // Your API endpoint URL
      String apiUrl = 'http://localhost:8000/msg/getSpecificUsermessages';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = {
        'receiverId': prefs.getString('user_id'),
      };
      print(data);

      // Make the POST request to your Node.js backend
      http.Response response = await http.post(Uri.parse(apiUrl), body: data);
      final jsonResponse = json.decode(response.body);

      // Update the UI with the new data
      print(jsonResponse);
      // Process the response
      if (response.statusCode == 200) {
        setState(() {
          sendersList =
              List<Map<String, dynamic>>.from(jsonResponse['responseData']);
        });
      } else {
        // Error response from the backend
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during the API request
      print('Error: $e');
    }
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 40),
                        const Text(
                          "Chats",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w900),
                        ),
                        Image.asset(
                          'assets/images/profile_big.png',
                          height: 70,
                          width: 70,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: sendersList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          // Access the sender's data from the sendersList
                          String firstname = sendersList[index]['firstname'];

                          return GestureDetector(
                            onTap: () => onSelectChat(
                              name: sendersList[index]['firstname'],
                              id: sendersList[index]['_id'],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/profile_big.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    firstname,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar:
            CustomBottomBar(widget.switchScreen, pageName: widget.pageName),
      ),
    );
  }
}
