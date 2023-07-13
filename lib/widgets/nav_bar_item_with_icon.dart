import 'package:flutter/material.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBarItemWithIcon extends StatelessWidget {
  final String text;
  final String icon;
  final String url;
  final IconData? iconWidget;

  const NavBarItemWithIcon(
      {required this.text,
      required this.icon,
      required this.url,
      Key? key,
      this.iconWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.all<Color>(CustomColors.primary),
      ),
      icon: iconWidget != null
          ? Icon(
              iconWidget!,
              color: Colors.black,
            )
          : Image.asset(icon),
      onPressed: () async {
        await launchUrl(Uri.parse(url));
      },
      label: SelectableText(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
