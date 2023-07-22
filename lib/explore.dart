import 'package:aspirant_minds/bottom_bar/custom_bottom_bar.dart';
import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";

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
  void onBtnPress() {
    widget.switchScreen("home");
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
                        iconStart: const Icon(Icons.search)),
                    const SizedBox(height: 15),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
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
                                  Container(
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
                                ],
                              ),
                            ],
                          ),
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
