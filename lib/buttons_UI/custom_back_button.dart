import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton(
    this.icon, {
    super.key,
    this.border,
    this.color,
    this.borderRadius,
    this.size,
    required this.onClick,
  });

  final Icon icon;
  final double? size;
  final Border? border;
  final double? borderRadius;
  final Color? color;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                width: 2,
                color: const Color.fromRGBO(240, 130, 0, 1),
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(7),
              onTap: onClick,
              child: const Icon(
                Icons.arrow_left_outlined,
                size: 40,
                color: Color.fromRGBO(240, 130, 0, 1),
              ),
            ),
          ),
        );
      },
    );
  }
}
