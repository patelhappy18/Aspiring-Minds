import 'package:flutter/material.dart';

class iconButton extends StatelessWidget {
  const iconButton(
      {super.key,
      required this.iconPath,
      required this.buttonText,
      required this.btnColor,
      required this.txtColor,
      required this.borderColor});

  final String buttonText;
  final String iconPath;
  final Color btnColor;
  final Color txtColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ElevatedButton.icon(
          onPressed: () {
            // Perform an action when the button is pressed
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(
                horizontal: constraints.maxWidth *
                    0.30, // Adjust the button padding based on available width
                vertical: 15.0,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(btnColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), // Set the border radius
                side: BorderSide(color: borderColor), // Set the border color
              ),
            ), // Set the background color
          ),
          label: Text(
            buttonText,
            style: TextStyle(
                fontSize: 11.0, color: txtColor, fontWeight: FontWeight.w800),
          ),
          icon: Image.asset(iconPath,
              width: 24, // Set the desired width of the icon
              height: 24),
        );
      },
    );
  }
}
