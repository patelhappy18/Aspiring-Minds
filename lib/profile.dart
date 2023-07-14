import 'package:flutter/material.dart';
// import "package:aspirant_minds/buttons_UI/icon_button.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";

class ProfilePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.50,
                color: Colors.black.withOpacity(0.11999999731779099),
              ),
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 151,
                top: 47,
                child: SizedBox(
                  width: 90,
                  height: 25,
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.20,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 162,
                top: 104,
                child: SizedBox(
                  width: 175,
                  height: 21,
                  child: Text(
                    'John Wick',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.95,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 162,
                top: 125,
                child: SizedBox(
                  width: 213,
                  height: 21,
                  child: Text(
                    'john@gmail.com',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.65,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 321,
                top: 26,
                child: Container(
                  width: 62,
                  height: 64,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 90,
                child: Container(
                  width: 106,
                  height: 109,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile_big.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 302,
                child: Container(
                  width: 338,
                  height: 51,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 338,
                          height: 51,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF6F6F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 5,
                        child: Container(
                          width: 41,
                          height: 42,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/jack.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 15,
                        child: SizedBox(
                          width: 244.40,
                          height: 21,
                          child: Text(
                            'Jack',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 357,
                child: Container(
                  width: 338,
                  height: 51,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 338,
                          height: 51,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF6F6F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 5,
                        child: Container(
                          width: 41,
                          height: 42,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/marry.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 15,
                        child: SizedBox(
                          width: 244.40,
                          height: 21,
                          child: Text(
                            'Marry',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 412,
                child: Container(
                  width: 338,
                  height: 51,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 338,
                          height: 51,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF6F6F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 5,
                        child: Container(
                          width: 41,
                          height: 42,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/mike.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 15,
                        child: SizedBox(
                          width: 244.40,
                          height: 21,
                          child: Text(
                            'Mike',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 45,
                top: 467,
                child: Container(
                  width: 338,
                  height: 51,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 338,
                          height: 51,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF6F6F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 7,
                        top: 5,
                        child: Container(
                          width: 41,
                          height: 42,
                          decoration: ShapeDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/lucy.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 55,
                        top: 15,
                        child: SizedBox(
                          width: 244.40,
                          height: 21,
                          child: Text(
                            'Lucy',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 50,
                top: 832,
                child: Container(
                  width: 325,
                  height: 51,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 700,
                child: Container(
                  width: 346,
                  height: 56.95,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 41,
                        top: 19,
                        child: Container(
                          width: 19,
                          height: 17,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/home_icon.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 122,
                        top: 19,
                        child: Container(
                          width: 19,
                          height: 17,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/message_icon.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 203,
                        top: 19,
                        child: Container(
                          width: 19,
                          height: 17,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/purchase_icon.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 283,
                        top: 19,
                        child: Container(
                          width: 19,
                          height: 17,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/profile_icon.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 147,
                top: 150,
                child: Container(
                  width: 131,
                  height: 36,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 0,
                        child: Container(
                          width: 110,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF08200),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        top: 9,
                        child: SizedBox(
                          width: 131,
                          height: 20,
                          child: Text(
                            'Edit profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.60,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 53,
                top: 944,
                child: Container(
                  width: 325,
                  height: 51,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 42,
                top: 221,
                child: Container(
                  width: 341,
                  height: 45,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF6F6F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 235,
                child: SizedBox(
                  width: 56,
                  height: 18,
                  child: Text(
                    'Courses',
                    style: TextStyle(
                      color: Color(0xFF5A546D),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.60,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 296,
                top: 235,
                child: SizedBox(
                  width: 56,
                  height: 18,
                  child: Text(
                    'General',
                    style: TextStyle(
                      color: Color(0xFF5A546D),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.60,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 154,
                top: 224,
                child: Container(
                  width: 116,
                  height: 39,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 116,
                          height: 39,
                          decoration: ShapeDecoration(
                            color: Color(0xFF5A546D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 18,
                        top: 11,
                        child: SizedBox(
                          width: 88,
                          height: 18,
                          child: Text(
                            'Connections',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.60,
                            ),
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
      ],
    );
  }
}
