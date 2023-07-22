import 'package:aspirant_minds/bottom_bar/custom_bottom_bar.dart';
import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Chat extends StatefulWidget {
  const Chat(this.switchScreen, {super.key, required this.pageName});

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  void onBtnPress() {
    widget.switchScreen("chat_list");
  }

  Future<void> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var chatDetails = json.decode(prefs.getString('chat') ?? "");
    setState(() {
      userName = chatDetails["name"];
      chatId = chatDetails["id"].toString();
    });
    // Do something with the user's email...
  }

  final List<String> messages = [];

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
                      reverse: true, // Start from the bottom
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Align(
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
                                    color: const Color.fromRGBO(240, 130, 0, 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 6,
                                          top: 2,
                                          bottom: 3,
                                        ),
                                        child: Text(
                                          messages[index],
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 0.75,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 20,
                                          top: 12,
                                        ),
                                        child: Text(
                                          "1:24 PM",
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
                            ));
                        // ListTile(
                        //   title: Text(messages[index]),
                        // );
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
            onSubmitted: _handleSubmitted,
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
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ),
      ],
    );
  }

  void _handleSubmitted(String message) {
    if (message.isNotEmpty) {
      setState(() {
        messages.insert(
            0, message); // Add new message to the beginning of the list
      });
      _textController
          .clear(); // Clear the input field after sending the message
    }
  }
}
