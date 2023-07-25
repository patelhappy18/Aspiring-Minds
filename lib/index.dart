import 'package:aspirant_minds/UI_Chat.dart';
import 'package:aspirant_minds/chat_list.dart';
import 'package:aspirant_minds/chats.dart';
import 'package:aspirant_minds/explore.dart';
import 'package:aspirant_minds/forgot_password.dart';
import 'package:aspirant_minds/courses.dart';
import 'package:aspirant_minds/login.dart';
import 'package:aspirant_minds/other_user_profile.dart';
import 'package:aspirant_minds/profile.dart';
import 'package:aspirant_minds/quiz.dart';
import 'package:flutter/material.dart';
import 'package:aspirant_minds/home.dart';
import 'package:aspirant_minds/register.dart';
import 'package:aspirant_minds/course_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() {
    return __Index();
  }
}

class __Index extends State<Index> {
  Widget? activeScreen;

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  Future<void> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user_name') != null) {
      setState(() {
        activeScreen = Courses(switchScreen, pageName: "courses");
      });
    } else {
      setState(() {
        activeScreen = Home(switchScreen, pageName: "home");
      });
    }

    // Do something with the user's email...
  }

  void switchScreen(String screenName) {
    setState(() {
      print(screenName);
      if (screenName == "register") {
        activeScreen = Register(switchScreen, pageName: "register");
      }
      if (screenName == "home") {
        activeScreen = Home(switchScreen, pageName: "home");
      }
      if (screenName == "login") {
        activeScreen = Login(switchScreen, pageName: "login");
      }
      if (screenName == "courses") {
        activeScreen = Courses(switchScreen, pageName: "courses");
      }
      if (screenName == "forgot_password") {
        activeScreen =
            ForgotPassword(switchScreen, pageName: "forgot_password");
      }
      if (screenName == "course_details") {
        activeScreen = CourseHomePage(switchScreen, pageName: "course_details");
      }
      if (screenName == "explore") {
        activeScreen = Explore(switchScreen, pageName: "explore");
      }
      if (screenName == "user_profile") {
        activeScreen = Profile(switchScreen, pageName: "user_profile");
      }
      if (screenName == "chat_list") {
        activeScreen = ChatList(switchScreen, pageName: "chat_list");
      }
      if (screenName == "chat") {
        activeScreen = Chat(switchScreen, pageName: "chat");
      }
      if (screenName == "other_user_profile") {
        activeScreen = OtherUserProfile(switchScreen, pageName: "chat");
      }
      if (screenName == "quiz") {
        activeScreen = Quiz(switchScreen, pageName: "quiz");
      }
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: activeScreen,
          // child: activeScreen,
          //another method to change the widgets
          // child: activeScreen == 'start-screen' ? startScreen(switchScreen()): const QuestionScreens(),
        ),
      ),
    );
  }
}
