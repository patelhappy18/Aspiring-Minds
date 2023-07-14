import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import "package:http/http.dart" as http;
import 'dart:convert';

class Register extends StatefulWidget {
  const Register(this.switchScreen, {super.key});

  final void Function(String screenName) switchScreen;

  @override
  State<Register> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  String _responseData = '';

  Future<void> fetchData() async {
    var url = Uri.parse('http://localhost:8080/endpoint');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        setState(() {
          _responseData = decodedData['message'];
        });
      } else {
        setState(() {
          _responseData = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseData = 'Error: $e';
      });
    }
  }

  void onBtnPress() {
    widget.switchScreen("home");
  }

  @override
  Widget build(context) {
    return SizedBox(
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
                  children: [
                    CustomBackButton(
                      const Icon(
                        Icons.arrow_left_outlined,
                        size: 40,
                        color: Color.fromRGBO(240, 130, 0, 1),
                      ),
                      onClick: onBtnPress,
                    )
                  ],
                ),
                Image.asset(
                  'assets/images/login_signup_logo.png',
                  height: 250,
                ), // Replace with your image source
                const SizedBox(height: 10),
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextBox(innerTxt: ' First Name'),
                      const SizedBox(height: 5),
                      TextBox(innerTxt: ' Last Name'),
                      const SizedBox(height: 5),
                      TextBox(innerTxt: ' Email Address'),
                      const SizedBox(height: 5),
                      TextBox(innerTxt: ' Password'),
                      const SizedBox(height: 5),
                      const Text(
                          "By signing up, you agree to our Terms & Conditions and Privacy Policy"),
                    ],
                  ),
                ),

                TxtButton(
                  buttonText: "Submit",
                  btnColor: const Color.fromRGBO(240, 130, 0, 1),
                  txtColor: Colors.white,
                  borderColor: Colors.grey,
                  isIconBtn: false,
                  onClick: fetchData,
                  width: 0.4,
                ),

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
                const SizedBox(height: 20),
                const CustomIconButton(
                  buttonText: 'Sign up with Google',
                  iconPath: 'assets/images/google_icon.png',
                  txtColor: Colors.white,
                  btnColor: Colors.black,
                  borderColor: Colors.grey,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
