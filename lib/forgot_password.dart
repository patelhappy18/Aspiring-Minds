import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword(this.switchScreen, {super.key, required this.pageName});

  final String pageName;
  final void Function(String screenName) switchScreen;

  @override
  State<ForgotPassword> createState() {
    return _ForgotPassword();
  }
}

class _ForgotPassword extends State<ForgotPassword> {
  String? currentState;
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  String _Error = "";

  @override
  void initState() {
    currentState = "getOTP";
    super.initState();
  }

  void onBtnPress() {
    widget.switchScreen("login");
  }

  void onGetOTP() async {
    // if (currentState == "verifyOTP") {
    //   currentState = "changePassword";
    // }
    // if(currentState == "getOTP"){
    // currentState = "verifyOTP";
    // }

    if (currentState == "getOTP") {
      String email = _emailController.text;
      String apiUrl = 'http://localhost:8000/users/email-send';
      var data = {'email': email};
      _Error = "";

      http.Response response = await http.post(Uri.parse(apiUrl), body: data);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        setState(() {
          currentState = "verifyOTP";
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_email', email);

        // prefs.setString(
        //     'user_name', jsonResponse['firstname'] + jsonResponse['lastname']);
        // widget.switchScreen("courses");
      } else {
        setState(() {
          _Error = 'No User found please register with us';
        });
      }
    }

    if (currentState == "verifyOTP") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('user_email');
      print(email);
      _Error = "";

      if (_otpController.text != "") {
        String apiUrl = 'http://localhost:8000/users/change-password';
        var data = {'email': email, 'otpCode': _otpController.text};

        http.Response response = await http.post(Uri.parse(apiUrl), body: data);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          setState(() {
            currentState = "changePassword";
          });
        }

        if (response.statusCode == 401) {
          setState(() {
            _Error = 'OTP you entered expired!';
          });
        }

        if (response.statusCode == 402) {
          print("Yoo");
          setState(() {
            _Error = 'Invalid OTP entered';
          });
        }
      }
    }

    if (currentState == "changePassword") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('user_email');
      _Error = "";

      if (_newPasswordController.text != "") {
        String apiUrl = 'http://localhost:8000/users/update-password-google';
        var data = {'email': email, 'password': _newPasswordController.text};
        print(data);
        http.Response response = await http.post(Uri.parse(apiUrl), body: data);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          widget.switchScreen("login");
        } else {
          setState(() {
            _Error = 'Something went wrong try again later';
          });
        }
      }
    }

    // Data to be sent in the request body
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
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/login_signup_logo.png',
                  height: 250,
                ), // Replace with your image source
                const SizedBox(height: 20),
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Column(
                    children: [
                      currentState == "getOTP"
                          ? TextBox(
                              innerTxt: ' Email Address',
                              customController: _emailController,
                              errorText: _Error == '' ? null : _Error,
                            )
                          : currentState == "verifyOTP"
                              ? TextBox(
                                  innerTxt: ' OTP',
                                  customController: _otpController,
                                  errorText: _Error == '' ? null : _Error,
                                )
                              : TextBox(
                                  innerTxt: ' New Password',
                                  customController: _newPasswordController,
                                  errorText: _Error == '' ? null : _Error,
                                ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                currentState == "getOTP"
                    ? TxtButton(
                        buttonText: "Get OTP",
                        btnColor: const Color.fromRGBO(240, 130, 0, 1),
                        txtColor: Colors.white,
                        borderColor: Colors.grey,
                        isIconBtn: false,
                        onClick: onGetOTP,
                        width: 0.4,
                      )
                    : currentState == "verifyOTP"
                        ? TxtButton(
                            buttonText: "Verify OTP",
                            btnColor: const Color.fromRGBO(240, 130, 0, 1),
                            txtColor: Colors.white,
                            borderColor: Colors.grey,
                            isIconBtn: false,
                            onClick: onGetOTP,
                            width: 0.39,
                          )
                        : TxtButton(
                            buttonText: "Change Password",
                            btnColor: const Color.fromRGBO(240, 130, 0, 1),
                            txtColor: Colors.white,
                            borderColor: Colors.grey,
                            isIconBtn: false,
                            onClick: onGetOTP,
                            width: 0.32,
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
