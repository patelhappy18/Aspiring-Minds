import 'package:flutter/material.dart';
import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import 'package:aspirant_minds/bottom_bar/custom_bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CourseHomePage extends StatefulWidget {
  const CourseHomePage(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<CourseHomePage> createState() {
    return _CourseHomePage();
  }
}

class _CourseHomePage extends State<CourseHomePage> {
  dynamic course = {};
  String userId = "";
  bool isPurchased = false;
  @override
  void initState() {
    super.initState();
    print("In page");
    getCourse();
  }

  void onBtnPress() {
    widget.switchScreen("courses");
  }

  void onModulePurchase(String module) {
    print(module);
  }

  void purchaseCourse() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Your API endpoint URL
      String apiUrl = 'http://localhost:8000/users/${userId}/purchased-course';
      // Make the POST request to your Node.js backend
      http.Response response =
          await http.post(Uri.parse(apiUrl), body: {"courseId": course["_id"]});

      // Process the responsel
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["_id"] != null) {
          prefs.setString(
            'user_purchased_courses',
            json.encode(
              jsonResponse["purchasedCourses"],
            ),
          );
          setState(() {
            isPurchased = true;
          });
        }
      }
    } catch (e) {
      // Error occurred during the API request
      print('Error: $e');
    }
  }

  Future<void> getCourse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      course = json.decode(prefs.getString('course') ?? " ");
      userId = prefs.getString('user_id') ?? "";
      var purchased_courses =
          json.decode(prefs.getString('user_purchased_courses') ?? "");
      print(prefs.getString('user_purchased_courses'));
      if (purchased_courses.contains(course["_id"])) {
        setState(() {
          isPurchased = true;
        });
        print(isPurchased);
      }
    });
    // Do something with the user's email...
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
                        Text(
                          course['title'],
                          style: const TextStyle(
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
                    Container(
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

                    const SizedBox(height: 15),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course['title'] ?? " ",
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w900),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Created By",
                                      style: TextStyle(fontSize: 19),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      course['author'] ?? " ",
                                      style: const TextStyle(
                                        fontSize: 19,
                                        color: Color(0xFFF08200),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xFFF08200),
                                    ),
                                    Text(
                                      course['rating'] != null
                                          ? course['rating'].toString()
                                          : " ",
                                      style: const TextStyle(
                                        fontSize: 19,
                                        color: Color(0xFFF08200),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            isPurchased
                                ? const SizedBox(
                                    width: 10,
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      purchaseCourse();
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
                                    child: Text(
                                      course['rating'] != null
                                          ? "Buy at \$ ${course['price'].toString()}"
                                          : " ",
                                      style: const TextStyle(
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListView.separated(
                            itemCount: course['modules'].length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        course['modules'][index]["name"],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        '\$\ ${course['modules'][index]['module_price'].toString()}',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(240, 130, 0, 1),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: <Widget>[
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: course['modules'][index]
                                              ["items"]
                                          .length,
                                      itemBuilder:
                                          (BuildContext context1, int index1) {
                                        return ListTile(
                                          title: Text("${index1 + 1}. " +
                                              course['modules'][index]["items"]
                                                  [index1]),
                                        );
                                      },
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          onModulePurchase(
                                              course['modules'][index]["name"]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(40),
                                          backgroundColor: const Color.fromRGBO(
                                              240, 130, 0, 1),
                                        ),
                                        child: const Text("Purchase "))
                                  ],
                                ),
                              );
                            },
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
