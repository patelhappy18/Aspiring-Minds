import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/icon_button.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  @override
  Widget build(context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/login_signup_logo.png',
            height: 250,
          ), // Replace with your image source
          const SizedBox(height: 10),

          TextBox(innerTxt: ' First Name'),
          const SizedBox(height: 20),

          TextBox(innerTxt: ' Last Name'),
          const SizedBox(height: 20),

          TextBox(innerTxt: ' Email Address'),
          const SizedBox(height: 20),

          TextBox(innerTxt: ' Password'),

          const SizedBox(height: 20),

          const TxtButton(
            buttonText: "Submit",
            btnColor: Colors.orange,
            txtColor: Colors.white,
            borderColor: Colors.grey,
            width: 0.20,
            isIconBtn: false,
          ),

          const SizedBox(height: 30),

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
                child: Text('OR', style: TextStyle(color: Colors.black)),
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
          const iconButton(
            buttonText: 'Sign up with Google',
            iconPath: 'assets/images/google_icon.png',
            txtColor: Colors.black,
            btnColor: Colors.white,
            borderColor: Colors.grey,
          ),
          const SizedBox(height: 10),

          const iconButton(
              buttonText: 'Sign up with Apple ID',
              iconPath: 'assets/images/apple_icon.png',
              txtColor: Colors.white,
              btnColor: Colors.black,
              borderColor: Colors.white),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
