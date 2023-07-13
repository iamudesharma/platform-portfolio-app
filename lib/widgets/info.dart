import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/custom_colors.dart';

class Info extends StatelessWidget {
  final double width;
  final double ratio;
  final bool isMoblie;
  final ScrollController scrollController;
  const Info(
      {required this.width,
      required this.ratio,
      required this.isMoblie,
      Key? key,
      required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width * ratio),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
                  '• I’m working with Bookish Santa as a Flutter Developer.',
                  style: GoogleFonts.getFont('Delius',
                      color: CustomColors.gray, fontSize: 13))
              .animate(
                  adapter: ScrollAdapter(
                scrollController,
                begin: isMoblie ? 800 : 240,
                end: isMoblie ? 850 : 360,
              ))
              .fade()
              .slide(),
          const SizedBox(height: 20),
          SelectableText('• The Only thing that makes me feel happy is coding.',
                  style: GoogleFonts.getFont('Delius',
                      color: CustomColors.gray, fontSize: 13))
              .animate(
                  adapter: ScrollAdapter(
                scrollController,
                begin: isMoblie ? 850 : 270,
                end: isMoblie ? 900 : 380,
              ))
              .fade()
              .slide(),
          const SizedBox(height: 20),
          SelectableText(
                  '• I always try to discover the new and the best technologies and use them to make my client feel comfortable and satisfied. ',
                  style: GoogleFonts.getFont('Delius',
                      color: CustomColors.gray, fontSize: 13))
              .animate(
                  adapter: ScrollAdapter(
                scrollController,
                begin: isMoblie ? 900 : 290,
                end: isMoblie ? 950 : 400,
              ))
              .fade()
              .slide(),
        ],
      ),
    );
  }
}
