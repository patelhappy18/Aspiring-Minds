import 'package:aspirant_minds/home.dart';
import 'package:aspirant_minds/profile.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setActivePage();
  }

  void setActivePage() {
    switch (widget.pageName) {
      case "courses":
        setState(() {
          _selectedIndex = 0;
        });
        break;

      case "chat_list":
        setState(() {
          _selectedIndex = 1;
        });
        break;

      case "explore":
        setState(() {
          _selectedIndex = 2;
        });
        break;

      case "user_profile":
        setState(() {
          _selectedIndex = 3;
        });
        break;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        widget.switchScreen("courses");
        break;

      case 1:
        widget.switchScreen("chat_list");
        break;

      case 2:
        widget.switchScreen("explore");
        break;

      case 3:
        widget.switchScreen("user_profile");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail),
                  label: 'Mail',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color.fromRGBO(240, 130, 0, 1),
              unselectedItemColor: Colors.black,
              onTap: _onItemTapped,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
            // bottomNavigationBar: CustomBottomBar(),
          ),
        ),
      ),
    );
  }
}
