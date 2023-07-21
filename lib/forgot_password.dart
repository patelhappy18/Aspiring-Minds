import "package:aspirant_minds/buttons_UI/custom_back_button.dart";
import "package:aspirant_minds/buttons_UI/custom_icon_button.dart";
import "package:flutter/material.dart";
import "package:aspirant_minds/buttons_UI/text_button.dart";
import "package:aspirant_minds/textbox_UI/text_box.dart";

class ForgotPassword extends StatefulWidget {
  const ForgotPassword(this.switchScreen, {super.key});

  final void Function(String screenName) switchScreen;

  @override
  State<ForgotPassword> createState() {
    return _ForgotPassword();
  }
}

class _ForgotPassword extends State<ForgotPassword> {
  bool? requestedToGetOTP;

  @override
  void initState() {
    requestedToGetOTP = false;
    super.initState();
  }

  void onBtnPress() {
    widget.switchScreen("home");
  }

  void onGetOTP() {
    setState(() {
      requestedToGetOTP = true;
    });
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
                // Column(
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                // Expanded(
                //   child: Column(
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       requestedToGetOTP == true
                //           ? TextBox(innerTxt: ' OTP')
                //           : TextBox(innerTxt: ' Email Address'),
                //       const SizedBox(height: 10),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 10),
                // requestedToGetOTP == true
                //     ? TxtButton(
                //         buttonText: "Verify OTP",
                //         btnColor: const Color.fromRGBO(240, 130, 0, 1),
                //         txtColor: Colors.white,
                //         borderColor: Colors.grey,
                //         isIconBtn: false,
                //         onClick: () {},
                //         width: 0.39,
                //       )
                //     : TxtButton(
                //         buttonText: "Get OTP",
                //         btnColor: const Color.fromRGBO(240, 130, 0, 1),
                //         txtColor: Colors.white,
                //         borderColor: Colors.grey,
                //         isIconBtn: false,
                //         onClick: onGetOTP,
                //         width: 0.4,
                //       ),
                // //   ],
                // // ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
