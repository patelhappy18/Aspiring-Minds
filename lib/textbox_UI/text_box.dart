import "package:flutter/material.dart";

class TextBox extends StatelessWidget {
  TextBox({
    super.key,
    required this.innerTxt,
    this.iconStart,
    this.customController,
    this.onSubmitted,
    this.onChange,
    this.isPassword,
    this.errorText,
  });

  final Icon? iconStart;
  final bool? isPassword;
  final String? errorText;
  String innerTxt;
  final TextEditingController? customController;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.width *
            0.14, // Adjust the width based on the screen size
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          controller: customController,
          onSubmitted: onSubmitted,
          onChanged: onChange,
          obscureText: isPassword ?? false,
          decoration: InputDecoration(
            hintText: innerTxt,
            errorText: errorText ?? null,
            prefixIcon: iconStart ?? null,
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
