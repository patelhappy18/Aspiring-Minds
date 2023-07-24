import 'package:aspirant_minds/bottom_bar/custom_bottom_bar.dart';
import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import 'package:aspirant_minds/tabbar_component/tabbar_component.dart';
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<Profile> createState() {
    return _Profile();
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

class _Profile extends State<Profile> {
  // late TabController tabviewController;
  String userName = '';
  String email = '';
  String userId = '';
  List courses = [];

  @override
  void initState() {
    super.initState();
    getUserInfo();
    // tabviewController = TabController(length: 2, vsync: this);
  }

  void getUserInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        userName = prefs.getString('user_name') ?? 'Harry';
        email = prefs.getString('user_email') ?? 'harry@gmail.com';
        userId = prefs.getString('user_id') ?? '';
      });

      String apiUrl = 'http://localhost:8000/courses/user/$userId';

      // Make the POST request to your Node.js backend
      http.Response response = await http.get(Uri.parse(apiUrl));

      // Process the responsel
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          courses = jsonResponse;
        });
        print(courses.length);
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  void onBtnPress() {
    widget.switchScreen("home");
  }

  Future<void> clearSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  bool containsUppercase(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool containsLowercase(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  bool containsDigit(String value) {
    return value.contains(RegExp(r'[0-9]'));
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
                        const SizedBox(
                          width: 40,
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
                              userName,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w900),
                            ),
                            Text(
                              email,
                              style: TextStyle(fontSize: 10),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                clearSharedPreferences();
                                widget.switchScreen("login");
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 240, 68, 0)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(
                                        color: Color.fromRGBO(240, 130, 0, 1)),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
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
                            Tab(text: 'General'),
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
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 15,
                                            top: 14,
                                            right: 15,
                                            bottom: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF6F6F6),
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                              const Text(
                                                "Jack",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            left: 15,
                                            top: 14,
                                            right: 15,
                                            bottom: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF6F6F6),
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                                              const Text(
                                                "Lucy",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              // width: size.width,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(height: 30),
                                    TextBox(innerTxt: ' First Name'),
                                    const SizedBox(height: 10),
                                    TextBox(innerTxt: ' Last Name'),
                                    const SizedBox(height: 10),
                                    TextBox(innerTxt: ' Email Address'),
                                    const SizedBox(height: 10),
                                    TxtButton(
                                      buttonText: "Edit Profile",
                                      btnColor:
                                          const Color.fromRGBO(240, 130, 0, 1),
                                      txtColor: Colors.white,
                                      borderColor: Colors.grey,
                                      isIconBtn: false,
                                      onClick: () {},
                                      width: 0.37,
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
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
        bottomNavigationBar: CustomBottomBar(
          widget.switchScreen,
          pageName: widget.pageName,
        ),
      ),
    );
  }
}
