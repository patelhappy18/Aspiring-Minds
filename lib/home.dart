import 'package:flutter/material.dart';
// import "package:aspirant_minds/buttons_UI/icon_button.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";

class Home extends StatelessWidget {
  const Home(this.switchScreen, {super.key});

  final void Function(String screenName) switchScreen;
////value of this.startQuiz will be directly assigned to startQuiz
//The reason why you cannot access the constructor arguments directly outside the constructor is because they are local variables within the constructor's scope. Once the constructor finishes executing and the object is created, these arguments are no longer accessible from outside the object.
//However, you can make the constructor arguments accessible by assigning them to instance variables within the constructor.

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/landing_page_image.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Life learning is the',
                            style: TextStyle(
                                color: Color.fromARGB(255, 3, 3, 3),
                                fontSize: 33,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'key to success.',
                            style: TextStyle(
                                color: Color.fromARGB(255, 3, 3, 3),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      TxtButton(
                        isIconBtn: false,
                        buttonText: "Get Started",
                        btnColor: Colors.orange,
                        txtColor: Colors.white,
                        borderColor: Colors.grey,
                        width: 0.35,
                        onClick: () {
                          switchScreen("register");
                        },
                      ),

                      SizedBox(height: 20),

                      const SizedBox(height: 20),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('OR',
                                style: TextStyle(color: Colors.black)),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // AnswerButton(answerText: 'Answer Text 1....', onTap: () {}),
                      // AnswerButton(answerText: 'Answer Text 2....', onTap: () {}),
                      // AnswerButton(answerText: 'Answer Text 3....', onTap: () {}),

                      TxtButton(
                        buttonText: 'Already have an account',
                        isIconBtn: false,
                        txtColor: Colors.white,
                        btnColor: Colors.black,
                        borderColor: Colors.white,
                        width: 0.24,
                        onClick: () {
                          switchScreen("login");
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
