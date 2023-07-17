import 'package:flutter/material.dart';
import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import 'package:aspirant_minds/bottom_bar/custom_bottom_bar.dart';

class CourseHomePage extends StatefulWidget {
  const CourseHomePage(this.switchScreen, {super.key});

  final void Function(String screenName) switchScreen;

  @override
  State<CourseHomePage> createState() {
    return _CourseHomePage();
  }
}

class _CourseHomePage extends State<CourseHomePage> {
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
                        CustomBackButton(
                          const Icon(
                            Icons.arrow_left_outlined,
                            size: 40,
                            color: Color.fromRGBO(240, 130, 0, 1),
                          ),
                          onClick: onBtnPress,
                        ),
                        const Text(
                          "Course Name",
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

                    // Replace with your image source
                    const SizedBox(height: 10),
                    // TextBox(innerTxt: ' Search', iconStart: Icon(Icons.search)),
                    const SizedBox(height: 15),
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

                    const SizedBox(height: 15),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Flutter with UX/UI course",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w900),
                        ),
                        Row(
                          // mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  "Created By Author",
                                  style: TextStyle(fontSize: 19),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFF08200),
                                    ),
                                    Text(
                                      "4.5",
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Color(0xFFF08200),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(240, 130, 0, 1)),
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
                                "Buy at \$\45",
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

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          right: 1,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 176,
                            crossAxisCount: 2,
                            mainAxisSpacing: 31,
                            crossAxisSpacing: 31,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      20,
                                    ),
                                    topRight: Radius.circular(
                                      20,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/coursethumbnail.png',
                                      height: 121,
                                      width: 156,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 17,
                                        top: 7,
                                      ),
                                      child: Text(
                                        "Coding",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 17,
                                        // bottom: 10,
                                      ),
                                      child: Text(
                                        "18 Courses",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }
}
