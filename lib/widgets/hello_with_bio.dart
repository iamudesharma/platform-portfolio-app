// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:portfolio/utils/custom_colors.dart';

class HelloWithBio extends StatelessWidget {
  final double width;
  final double ratio;
  final bool isMoblie;
  final ScrollController scrollController;
  const HelloWithBio({
    Key? key,
    required this.width,
    required this.isMoblie,
    required this.ratio,
    required this.scrollController,
  }) : super(key: key);
  // final

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width * ratio),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText('Hello!  I’m Udesh Sharma',
                  style: GoogleFonts.getFont('Delius',
                      color: Colors.white, fontSize: 26))
              .animate(
                  adapter: ScrollAdapter(
                scrollController,
                begin: isMoblie ? 700 : 190,
                end: isMoblie ? 800 : 300,
              ))
              .fade()
              .slide(),
          const SizedBox(height: 5),
          SelectableText(
                  'I seek challenging opportunities where I can fully use my skills for the success.',
                  style: GoogleFonts.getFont('Delius',
                      color: CustomColors.gray, fontSize: 16))
              .animate(
                  adapter: ScrollAdapter(
                scrollController,
                begin: isMoblie ? 750 : 220,
                end: isMoblie ? 850 : 320,
              ))
              .fade()
              .slide(),
        ],
      ),
    );
  }
}
