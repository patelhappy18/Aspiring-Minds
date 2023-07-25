import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<Register> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();

  String _firstNameError = '';
  String _lastNameError = '';
  String _emailError = '';
  String _passwordError = '';

  void onBtnPress() {
    widget.switchScreen("home");
  }

  bool isValidEmail(String email) {
    // Regular expression pattern for a valid email address
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Use the regex pattern to check if the email matches the valid format
    return emailRegex.hasMatch(email);
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Call the function to make the API request to your Node.js backend
  }

  bool containsUppercase(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool containsLowercase(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  bool containsDigit(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }

  Future<void> registerUser() async {
    String demo = "";
    String email = _emailController.text;
    String password = _passwordController.text;
    String firstname = _firstnameController.text;
    String lastname = _lastnameController.text;

    if (firstname == '') {
      setState(() {
        _firstNameError = "Enter First Name";
      });
      return;
    } else {
      setState(() {
        _firstNameError = "";
      });
    }

    if (lastname == '') {
      setState(() {
        _lastNameError = "Enter Last Name";
      });
      return;
    } else {
      setState(() {
        _lastNameError = "";
      });
    }

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
      print(password);

      if (password.length < 8) {
        print("Less then 8");
        setState(() {
          _passwordError = 'Password must be at least 8 characters long';
        });
        return;
      }
      if (!containsUppercase(password) ||
          !containsLowercase(password) ||
          !containsDigit(password)) {
        print("Validation failed");

        setState(() {
          _passwordError = 'at least one uppercase, lowercase, and one digit';
        });
        return;
      } else {
        setState(() {
          _passwordError = '';
        });
      }
    }

    try {
      // Your API endpoint URL

      String apiUrl = 'http://localhost:8000/users/registerNewUser';

      // Data to be sent in the request body
      var data = {
        'email': email,
        'password': password,
        'firstname': firstname,
        'lastname': lastname
      };
      // Make the POST request to your Node.js backend
      http.Response response = await http.post(Uri.parse(apiUrl), body: data);
      print(response);

      // Process the response
      if (response.statusCode == 200) {
        // Successful response from the backend
        print("=====>>>$response");

        String userEmail =
            'example@example.com'; // Replace with actual user email
        final jsonResponse = json.decode(response.body);
        // Save user email in shared_preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_email', email);
        prefs.setString('user_name', firstname);
        prefs.setString('user_id', jsonResponse['_id']);
        prefs.setString('user_purchased_courses',
            json.encode(jsonResponse["purchasedCourses"]));
        prefs.setString('user_purchased_modules',
            json.encode(jsonResponse["purchasedModules"]));
        widget.switchScreen("courses");
      } else if (response.statusCode == 404) {
        setState(() {
          _emailError = 'User already registered';
        });
      } else {
        // Error response from the backend
        print('Request failed with status: ${response.statusCode}');
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
                const SizedBox(height: 0),
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
                  height: 240,
                ), // Replace with your image source
                const SizedBox(height: 5),
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
                const SizedBox(height: 5),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextBox(
                        customController: _firstnameController,
                        innerTxt: "FirstName",
                        errorText:
                            _firstNameError == '' ? null : _firstNameError,
                      ),
                      const SizedBox(height: 5),
                      TextBox(
                        customController: _lastnameController,
                        innerTxt: 'LastName',
                        errorText: _lastNameError == '' ? null : _lastNameError,
                      ),
                      const SizedBox(height: 5),
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
                  onClick: registerUser,
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
                const SizedBox(height: 10),
                const CustomIconButton(
                  buttonText: 'Sign up with Google',
                  iconPath: 'assets/images/google_icon.png',
                  txtColor: Colors.white,
                  btnColor: Colors.black,
                  borderColor: Colors.grey,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
