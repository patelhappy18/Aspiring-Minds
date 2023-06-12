import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home(this.startQuiz, {super.key});

  final void Function()
      startQuiz; //value of this.startQuiz will be directly assigned to startQuiz
//The reason why you cannot access the constructor arguments directly outside the constructor is because they are local variables within the constructor's scope. Once the constructor finishes executing and the object is created, these arguments are no longer accessible from outside the object.
//However, you can make the constructor arguments accessible by assigning them to instance variables within the constructor.

  void rollDice() {}
  @override
  Widget build(context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          //This is the 1st method to change the opacity
          'assets/images/login_signup_logo.png',
          width: 300,
        ),
        // Opacity( //wrap using this in order to change the opacity.
        //   opacity: 0.5,
        //   child: Image.asset(
        //     //right click and click on refactor and then wrap with widget
        //     'assets/images/quiz-logo.png',
        //     width: 300,
        //   ),
        // ),
        const SizedBox(
          height: 80,
        ),
        const Text(
          'Learn with Aspirant Minds !',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 80,
        ),
        OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.orange),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text(
              'Start Learning',
            )),
        // OutlinedButton(
        //   onPressed: () {},
        //   child: const Text(
        //     'Start Quiz 1',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
      ]),
    );
  }
}
