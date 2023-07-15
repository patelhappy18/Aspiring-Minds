import 'package:aspirant_minds/login.dart';
import 'package:aspirant_minds/other_user_profile.dart';
import 'package:aspirant_minds/profile.dart';
import 'package:flutter/material.dart';
import 'package:aspirant_minds/home.dart';
import 'package:aspirant_minds/register.dart';

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
    activeScreen = Home(switchScreen);
    super.initState();
  }

  void switchScreen(String screenName) {
    setState(() {
      if (screenName == "register") {
        activeScreen = Register(switchScreen);
      }
      if (screenName == "home") {
        activeScreen = Home(switchScreen);
      }
      if (screenName == "login") {
        activeScreen = Login(switchScreen);
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
          // child: CourseHomePage(switchScreen),
          child: Profile(switchScreen),
          //another method to change the widgets
          // child: activeScreen == 'start-screen' ? startScreen(switchScreen()): const QuestionScreens(),
        ),
      ),
    );
  }
}
