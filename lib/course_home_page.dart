import 'package:flutter/material.dart';
// import "package:aspirant_minds/buttons_UI/icon_button.dart";

class CourseHomePage extends StatelessWidget {
  const CourseHomePage(this.switchScreen, {super.key});
  final void Function(String screenName) switchScreen;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
                  left: 42,
                  top: 442,
                  child: Container(
                    width: 341,
                    height: 542,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 451,
                  child: Container(
                    width: 325,
                    height: 199,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 325,
                            height: 199,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          top: 48,
                          child: Container(
                            width: 235,
                            height: 84,
                            child: const Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 63,
                                  child: SizedBox(
                                    width: 235,
                                    height: 21,
                                    child: Text(
                                      'Importance of is UX/UI?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.65,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 42,
                                  child: SizedBox(
                                    width: 235,
                                    height: 21,
                                    child: Text(
                                      'Why is UX/UI?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.65,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: SizedBox(
                                    width: 235,
                                    height: 21,
                                    child: Text(
                                      'Introduction',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.65,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 21,
                                  child: SizedBox(
                                    width: 235,
                                    height: 21,
                                    child: Text(
                                      'What is UX/UI?',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.65,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 13,
                          top: 15,
                          child: SizedBox(
                            width: 235,
                            height: 21,
                            child: Text(
                              'Module one',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.80,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 296,
                          top: 18,
                          child: Container(
                            width: 17,
                            height: 15,
                            decoration: ShapeDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/course_home_page/Down_arrow.png"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 224,
                          top: 15,
                          child: SizedBox(
                            width: 57,
                            height: 21,
                            child: Text(
                              '\$4',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFFF08200),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.80,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  left: 120,
                  top: 47,
                  child: SizedBox(
                    width: 200,
                    height: 31,
                    child: Text(
                      'Course Name',
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
                const Positioned(
                  left: 42,
                  top: 343,
                  child: SizedBox(
                    width: 321,
                    height: 21,
                    child: Text(
                      'Flutter with UX/UI course',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 42,
                  top: 371,
                  child: SizedBox(
                    width: 97,
                    height: 21,
                    child: Text(
                      'Created By',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 143,
                  top: 371,
                  child: SizedBox(
                    width: 232,
                    height: 21,
                    child: Text(
                      'Author',
                      style: TextStyle(
                        color: Color(0xFFF08200),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 64,
                  top: 399,
                  child: SizedBox(
                    width: 30,
                    height: 21,
                    child: Text(
                      '4.5',
                      style: TextStyle(
                        color: Color(0xFFF08200),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.80,
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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/course_home_page/profile.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 42,
                  top: 114,
                  child: Container(
                    width: 341,
                    height: 205,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/images/course_home_page/main_photo.png"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 42,
                  top: 43,
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
                                side: const BorderSide(
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
                              decoration: const ShapeDecoration(
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
                  left: 42,
                  top: 399,
                  child: Container(
                    width: 17,
                    height: 15,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/course_home_page/star_1.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 658,
                  child: Container(
                    width: 325,
                    height: 51,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
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
                        const Positioned(
                          left: 12,
                          top: 15,
                          child: SizedBox(
                            width: 235,
                            height: 21,
                            child: Text(
                              'Module two',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.80,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 295,
                          top: 18,
                          child: Container(
                            width: 17,
                            height: 15,
                            decoration: ShapeDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/course_home_page/Down_arrow.png"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 224,
                          top: 15,
                          child: SizedBox(
                            width: 57,
                            height: 21,
                            child: Text(
                              '\$4',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFFF08200),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.80,
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
                  top: 716,
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
                const Positioned(
                  left: 63,
                  top: 731,
                  child: SizedBox(
                    width: 235,
                    height: 21,
                    child: Text(
                      'Module three',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 274,
                  top: 731,
                  child: SizedBox(
                    width: 57,
                    height: 21,
                    child: Text(
                      '\$4',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFF08200),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 346,
                  top: 734,
                  child: Container(
                    width: 17,
                    height: 15,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/images/course_home_page/Down_arrow.png"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 774,
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
                const Positioned(
                  left: 64,
                  top: 789,
                  child: SizedBox(
                    width: 235,
                    height: 21,
                    child: Text(
                      'Module four',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 275,
                  top: 789,
                  child: SizedBox(
                    width: 57,
                    height: 21,
                    child: Text(
                      '\$4',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFF08200),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 347,
                  top: 792,
                  child: Container(
                    width: 17,
                    height: 15,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/images/course_home_page/Down_arrow.png"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                  top: 820,
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
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/course_home_page/Down_arrow.png"),
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
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/course_home_page/Down_arrow.png"),
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
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/course_home_page/Down_arrow.png"),
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
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/course_home_page/Down_arrow.png"),
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
                  left: 50,
                  top: 606,
                  child: Container(
                    width: 325,
                    height: 44,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFF08200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 141,
                  top: 616,
                  child: SizedBox(
                    width: 149,
                    height: 20,
                    child: Text(
                      'Purchase Module',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 259,
                  top: 385,
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
                            height: 15,
                            child: Text(
                              'Buy at \$45\n',
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
                  left: 53,
                  top: 886,
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
                const Positioned(
                  left: 64,
                  top: 903,
                  child: SizedBox(
                    width: 235,
                    height: 21,
                    child: Text(
                      'Module six',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 275,
                  top: 903,
                  child: SizedBox(
                    width: 57,
                    height: 21,
                    child: Text(
                      '\$4',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFFF08200),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 347,
                  top: 906,
                  child: Container(
                    width: 17,
                    height: 15,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/images/course_home_page/Down_arrow.png"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
