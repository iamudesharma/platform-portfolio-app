import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/utils/custom_colors.dart';

class NavBarItem extends StatelessWidget {
  final String text;
  final Function onTap;
  late final RxBool isHighlited;
  NavBarItem({required this.text, required this.onTap, Key? key})
      : super(key: key) {
    isHighlited = false.obs;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap(),
      style: TextButton.styleFrom(),
      child: SelectableText(
        text,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
