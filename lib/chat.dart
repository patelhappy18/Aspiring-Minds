import "package:flutter/material.dart";

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 430,
          height: 840,
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
                left: 161,
                top: 70,
                child: SizedBox(
                  width: 175,
                  height: 27,
                  child: Text(
                    'John Wick',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.20,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 89,
                top: 53,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/chat_profile.png"),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 262,
                top: 731,
                child: Container(
                  width: 121,
                  height: 34,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 121,
                          height: 34,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF6F6F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 8,
                        child: SizedBox(
                          width: 45,
                          height: 11.35,
                          child: Text(
                            'Hello',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 75,
                        top: 17,
                        child: SizedBox(
                          width: 42,
                          height: 13,
                          child: Opacity(
                            opacity: 0.40,
                            child: Text(
                              '1:24 PM',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 44,
                top: 773,
                child: Container(
                  width: 121,
                  height: 34,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 121,
                          height: 34,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF08200),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 8,
                        child: SizedBox(
                          width: 45,
                          height: 11.35,
                          child: Text(
                            'Hey',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 75,
                        top: 17,
                        child: SizedBox(
                          width: 42,
                          height: 13,
                          child: Opacity(
                            opacity: 0.40,
                            child: Text(
                              '1:30 PM',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 97,
                top: 235,
                child: SizedBox(
                  width: 56,
                  height: 18,
                  child: Text(
                    'Courses',
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
              Positioned(
                left: 48,
                top: 70,
                child: Container(
                  width: 30,
                  height: 30,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFF08200)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 23,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(-1.57),
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF08200),
                              shape: StarBorder.polygon(sides: 3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 326,
                top: 823,
                child: Container(
                  width: 56.95,
                  height: 56.95,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF08200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 44,
                top: 823,
                child: Container(
                  width: 278,
                  height: 56.95,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 278,
                          height: 56.95,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 23.85,
                        top: 19,
                        child: SizedBox(
                          width: 171.57,
                          height: 18.98,
                          child: Opacity(
                            opacity: 0.40,
                            child: Text(
                              'Message',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 353.68,
                top: 834,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0, 0.0)
                    ..rotateZ(0.79),
                  child: Container(
                    width: 24.19,
                    height: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/24x25"),
                        fit: BoxFit.contain,
                      ),
                    ),
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
