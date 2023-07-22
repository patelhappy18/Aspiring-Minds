import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<Login> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  void onBtnPress() {
    widget.switchScreen("home");
  }

  void onForgotPasswordPress() {
    widget.switchScreen("forgot_password");
  }

  bool isValidEmail(String email) {
    // Regular expression pattern for a valid email address
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Use the regex pattern to check if the email matches the valid format
    return emailRegex.hasMatch(email);
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String demo = "";
  String email = "";
  String password = "";
  String errorMessage = "";

  String _emailError = '';
  String _passwordError = '';

  void _login() async {
    email = _emailController.text;
    password = _passwordController.text;

    if (email == '') {
      setState(() {
        _emailError = 'Enter your Email';
      });
      return;
    } else {
      if (!isValidEmail(email)) {
        setState(() {
          _emailError = 'Enter your valid Email';
        });
        return;
      } else {
        setState(() {
          _emailError = "";
        });
      }
    }

    if (password == '') {
      setState(() {
        _passwordError = "Enter Password";
      });
      return;
    } else {
      setState(() {
        _passwordError = "";
      });
    }

    try {
      // Your API endpoint URL
      String apiUrl = 'http://localhost:8000/users/getUser';

      // Data to be sent in the request body
      var data = {'email': email, 'password': password};
      print(data);
      // Make the POST request to your Node.js backend
      http.Response response = await http.post(Uri.parse(apiUrl), body: data);
      print(response);

      // Process the responsel
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // final Map jsonResponse = json.decode(response.body);
        // final signUp = SignUpResponse.fromJson(jsonResponse);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_email', email);
        prefs.setString('user_name', jsonResponse['firstname']);
        prefs.setString('user_id', jsonResponse['_id']);
        prefs.setString('user_purchased_courses',
            json.encode(jsonResponse["purchasedCourses"]));
        widget.switchScreen("courses");
      } else if (response.statusCode == 404) {
        // User not found

        setState(() {
          errorMessage =
              'User not found. Please check your email and password.';
        });
      } else if (response.statusCode == 401) {
        // Incorrect password
        setState(() {
          errorMessage = 'Incorrect password. Please try again.';
        });
      } else {
        // Other error response from the backend
        setState(() {
          errorMessage =
              'An unexpected error occurred. Please try again later.';
        });
      }
    } catch (e) {
      // Error occurred during the API request
      print('Error: $e');
    }
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/login_signup_logo.png',
                  height: 200,
                ), // Replace with your image source
                const SizedBox(height: 20),
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextBox(
                        customController: _emailController,
                        innerTxt: 'Email',
                        errorText: _emailError == '' ? null : _emailError,
                      ),
                      // TextBox(innerTxt: ' Email Address'),
                      const SizedBox(height: 5),
                      TextBox(
                        customController: _passwordController,
                        innerTxt: 'Password',
                        errorText: _passwordError == '' ? null : _passwordError,
                        isPassword: true,
                      ),
                      // TextBox(innerTxt: ' Password'),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: onForgotPasswordPress,
                          child: const Text("Forgot Password?"),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    demo,
                  ),
                ),
                const SizedBox(height: 10),
                TxtButton(
                  buttonText: 'Login',
                  btnColor: const Color.fromRGBO(240, 130, 0, 1),
                  txtColor: Colors.white,
                  borderColor: Colors.grey,
                  isIconBtn: false,
                  onClick: _login,
                  width: 0.4,
                ),

                const SizedBox(height: 19),

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
                const CustomIconButton(
                  buttonText: 'Login with Google',
                  iconPath: 'assets/images/google_icon.png',
                  txtColor: Colors.white,
                  btnColor: Colors.black,
                  borderColor: Colors.grey,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
