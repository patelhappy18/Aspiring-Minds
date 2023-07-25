import 'package:aspirant_minds/bottom_bar/custom_bottom_bar.dart';
import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import 'package:aspirant_minds/tabbar_component/tabbar_component.dart';
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OtherUserProfile extends StatefulWidget {
  OtherUserProfile(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<OtherUserProfile> createState() {
    return _OtherUserProfile();
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

class _OtherUserProfile extends State<OtherUserProfile> {
  // late TabController tabviewController;
  dynamic otherUserData = {};
  String fullName = "";
  String userId = "";
  List courses = [];
  List connections = [];
  String isFriend = "notfriend";
  @override
  void initState() {
    super.initState();
    getSelectedUserData();
    getUserInfo();
    // tabviewController = TabController(length: 2, vsync: this);
  }

  void onBtnPress() {
    widget.switchScreen("explore");
  }

  void getSelectedUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var selectedUserData = json.decode(prefs.getString('other_user') ?? "");
      if (selectedUserData != null) {
        var firstname = selectedUserData['firstname'];
        var lastname = selectedUserData['lastname'];
        setState(() {
          otherUserData = selectedUserData;
          fullName = "$firstname $lastname";
          userId = selectedUserData['_id'];
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void getUserInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String apiUrl = 'http://localhost:8000/courses/user/$userId';

      // Make the POST request to your Node.js backend
      http.Response response = await http.get(Uri.parse(apiUrl));

      // Process the responsel
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          courses = jsonResponse;
        });

        String connectionUrl =
            'http://localhost:8000/users/connections/pending/$userId';

        // Make the POST request to your Node.js backend
        http.Response responseConnectionAPI =
            await http.get(Uri.parse(connectionUrl));

        // Process the responsel
        if (responseConnectionAPI.statusCode == 200) {
          final connectionAPIResponse = json.decode(responseConnectionAPI.body);
          List filteredConnections = [];
          print(connectionAPIResponse);
          connectionAPIResponse.map((element) {
            if (element['isSent'] == false) {
              filteredConnections.add(element);
            }
          });
          setState(() {
            connections = filteredConnections;
          });
          connectionAPIResponse.forEach((element) {
            if (element['user']["_id"] == prefs.getString("user_id")) {
              setState(() {
                isFriend = element['status'];
              });
            }
          });
          if (isFriend == "notfriend") {
            getConnectionInfo();
          }
        }
        print("connections $connections - isFriend $isFriend");
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  void getConnectionInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String connectionUrl =
          'http://localhost:8000/users/connections/accepted/$userId';

      // Make the POST request to your Node.js backend
      http.Response responseConnectionAPI =
          await http.get(Uri.parse(connectionUrl));

      // Process the responsel
      if (responseConnectionAPI.statusCode == 200) {
        final connectionAPIResponse = json.decode(responseConnectionAPI.body);
        print(connectionAPIResponse);
        setState(() {
          connections = connectionAPIResponse;
        });
        connectionAPIResponse.forEach((element) {
          if (element['user']["_id"] == prefs.getString("user_id")) {
            setState(() {
              isFriend = element['status'];
            });
          }
        });
      }
      print("connections $connections - isFriend $isFriend");
    } catch (e) {
      print("Error : $e");
    }
  }

  void onReqAction() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var senderUserId = prefs.getString("user_id");
      if (senderUserId != null && userId != null) {
        // Your API endpoint URL
        String apiUrl = 'http://localhost:8000/users/sendFriendRequest';

        // Data to be sent in the request body
        var data = {'senderUserId': senderUserId, 'receiverUserId': userId};
        print(data);
        // Make the POST request to your Node.js backend
        http.Response response = await http.post(Uri.parse(apiUrl), body: data);
        print(response);

        // Process the responsel
        if (response.statusCode == 200) {
          getUserInfo();
        }
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
                        const Text(
                          "Profile",
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/images/profile_big.png',
                          height: 170,
                          width: 100,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              otherUserData['email'],
                              style: TextStyle(fontSize: 10),
                            ),
                            isFriend == "notfriend"
                                ? ElevatedButton(
                                    onPressed: () {
                                      onReqAction();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromRGBO(
                                                  240, 130, 0, 1)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: const BorderSide(
                                              color: Color.fromRGBO(
                                                  240, 130, 0, 1)),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Follow",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  )
                                : isFriend == "pending"
                                    ? ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color.fromRGBO(
                                                      240, 130, 0, 1)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              side: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      240, 130, 0, 1)),
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Requested",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      )
                                    : isFriend == "accepted"
                                        ? ElevatedButton(
                                            onPressed: () {},
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color.fromRGBO(
                                                          240, 130, 0, 1)),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          240, 130, 0, 1)),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              "Chat",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          )
                                        : const SizedBox(
                                            width: 10,
                                          ),
                          ],
                        ),
                      ],
                    ),
                    // const SizedBox(height: 5),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          right: 1,
                        ),
                        child: TabBarComponent(
                          tabs: const [
                            Tab(text: 'Courses'),
                            Tab(text: 'Connections'),
                          ],
                          tabComponents: [
                            SizedBox(
                              // width: size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 300,
                                        child: ListView.separated(
                                            itemBuilder: (context, index) =>
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15,
                                                    top: 14,
                                                    right: 15,
                                                    bottom: 14,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF6F6F6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 2,
                                                          bottom: 3,
                                                        ),
                                                        child: Text(
                                                          courses[index]
                                                              ['title'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            letterSpacing: 0.8,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const Divider(),
                                            itemCount: courses.length),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 300,
                                        child: ListView.separated(
                                            itemBuilder: (context, index) =>
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 15,
                                                    top: 14,
                                                    right: 15,
                                                    bottom: 14,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF6F6F6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
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
                                                        connections[index]
                                                                ["user"]
                                                            ['firstname'],
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          letterSpacing: 0.8,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const Divider(),
                                            itemCount: connections.length),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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