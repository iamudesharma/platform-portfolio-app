import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Description extends StatelessWidget {
  final bool isVertical;
  final double width;
  const Description({required this.isVertical, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isVertical ? double.infinity : width * 0.29,
      child: Column(
        crossAxisAlignment:
            isVertical ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: CustomColors.primary,
              ),
              onPressed: () {},
              // margin: const EdgeInsets.symmetric(horizontal: 10),
              // width: 135,
              // height: 40,
              // alignment: Alignment.center,
              // color: CustomColors.primary,
              child: const Center(
                  child: Text(
                'Software Developer',
              ))).animate().fade().slideX(),
          SizedBox(height: 0.015 * width),
          SelectableText('Talk is cheap.',
                  style: GoogleFonts.getFont('Delius',
                      color: Colors.white, fontSize: 35))
              .animate()
              .fade()
              .slideX(),
          const SizedBox(height: 5),
          Text('Show me the code.',
                  style: GoogleFonts.getFont('Delius',
                      color: Colors.white, fontSize: 32))
              .animate()
              .fade()
              .slideX(),
          const SizedBox(height: 20),
          SizedBox(
            width: isVertical ? double.infinity : width * 0.29,
            height: 90,
            child: AnimatedTextKit(
              displayFullTextOnTap: true,
              repeatForever: true,
              pause: const Duration(seconds: 2),
              animatedTexts: [
                TyperAnimatedText(
                    "I'm developing mobile,frontend and backend applications",
                    textAlign: isVertical ? TextAlign.center : TextAlign.start,
                    textStyle: GoogleFonts.getFont('Delius',
                        color: CustomColors.gray, fontSize: 15)),
              ],
            ),
          ).animate().fade().slideX(),
          InkWell(
            onTap: () async => !await launchUrlString(
                'https://mail.google.com/mail/u/0/?fs=1&to=udesh2568@gmail.com&tf=cm'),
            child: Text("Let's chat",
                style: GoogleFonts.getFont('Delius',
                    decoration: TextDecoration.underline,
                    color: CustomColors.primary,
                    fontSize: 20)),
          ).animate().fade().slideX(),
        ],
      ),
    );
  }
}
