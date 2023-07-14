import 'package:flutter/material.dart';

class TxtButton extends StatelessWidget {
  const TxtButton({
    super.key,
    required this.onClick,
    required this.buttonText,
    required this.btnColor,
    required this.txtColor,
    required this.borderColor,
    required this.isIconBtn,
    required this.width,
  });

  final String buttonText;
  final Color btnColor;
  final Color txtColor;
  final Color borderColor;
  final bool isIconBtn;
  final double width;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return isIconBtn
            ? ElevatedButton.icon(
                onPressed: () {
                  onClick();
                  // Perform an action when the button is pressed
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth *
                          0.90, // Adjust the button padding based on available width
                      vertical: 15.0,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(btnColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25), // Set the border radius
                      side: BorderSide(
                          color: borderColor), // Set the border color
                    ),
                  ), // Set the background color
                ),
                label: Text(
                  buttonText,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: txtColor,
                      fontWeight: FontWeight.w800),
                ),
                icon: const Icon(Icons.arrow_circle_right),
              )
            : Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: ElevatedButton(
                  onPressed: () {
                    onClick();
                    // Perform an action when the button is pressed
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth *
                            width, // Adjust the button padding based on available width
                        vertical: 15.0,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(btnColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Set the border radius
                        side: BorderSide(
                            color: borderColor), // Set the border color
                      ),
                    ), // Set the background color
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                        fontSize: 13.0,
                        color: txtColor,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              );
      },
    );
  }
}
