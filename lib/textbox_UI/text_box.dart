import "package:flutter/material.dart";

class TextBox extends StatelessWidget {
  TextBox({super.key, required this.innerTxt});

  String innerTxt;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.width *
            0.14, // Adjust the width based on the screen size
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: innerTxt,
            // border: const OutlineInputBorder(),
            filled: true,
            fillColor: const Color.fromARGB(
                150, 247, 247, 247), // Set the background color
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ), // Set the border color
              borderRadius:
                  BorderRadius.circular(50.0), // Set the border radius
            ),
          ),
        ),
      ),
    );
  }
}
