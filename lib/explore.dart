import 'package:aspirant_minds/bottom_bar/custom_bottom_bar.dart';
import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Explore extends StatefulWidget {
  const Explore(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<Explore> createState() {
    return _Explore();
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

class _Explore extends State<Explore> {
  String searchString = "";
  List fetchedUsers = [];
  void onBtnPress() {
    widget.switchScreen("home");
  }

  void onSearch(String text) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (text != "") {
        var userId = prefs.getString('user_id');
        // Your API endpoint URL
        String apiUrl = 'http://localhost:8000/users/searchUsers?q=$text';

        // Data to be sent in the request body
        var data = {'userId': userId};
        print(data);
        // Make the POST request to your Node.js backend
        http.Response response = await http.post(Uri.parse(apiUrl), body: data);
        print(response);

        // Process the responsel
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          if (jsonResponse.length > 0) {
            setState(() {
              fetchedUsers = jsonResponse;
            });
            print("Searched users : $fetchedUsers");
            print(fetchedUsers.length);
          }
        }
      } else {
        setState(() {
          fetchedUsers = [];
        });
      }
    } catch (e) {
      // Error occurred during the API request
      print('Error: $e');
    }
  }

  void onSelectUser(dynamic userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('other_user', json.encode(userData));
      widget.switchScreen("other_user_profile");
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
                          "Explore",
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
                    const SizedBox(height: 10),
                    TextBox(
                        innerTxt: ' Search',
                        onChange: (String text) {
                          onSearch(text);
                        },
                        iconStart: const Icon(Icons.search)),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 450,
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              shrinkWrap: true,
                              itemCount: fetchedUsers.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () => onSelectUser(fetchedUsers[index]),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    top: 14,
                                    right: 15,
                                    bottom: 14,
                                  ),
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
                                        fetchedUsers[index]['firstname'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
