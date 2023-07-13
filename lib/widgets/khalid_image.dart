import 'package:flutter/material.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/utils/image_asset_constants.dart';

import '../assets.dart';

class KhalidImage extends StatelessWidget {
  final double width;
  const KhalidImage({
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width * 0.29,
          height: width * 0.3,
          color: Colors.transparent,
          constraints: const BoxConstraints(
            maxWidth: 370,
          ),
        ),
        Positioned(
          top: width * 0.17,
          left: 0,
          child: Image.asset(
            Assets.images.firebasePNG,
            width: width * 0.07,
            height: width * 0.07,
          ),
        ),
        Positioned(
          top: width * 0.19,
          right: width * 0.010,
          child: FlutterLogo(
            size: width * 0.06,
          ),
        ),
        Positioned(
            top: width * 0.14,
            right: width * 0.010,
            child: Image.asset(
              Assets.images.awsPNG,
              width: width * 0.06,
              height: width * 0.058,
            )),
        // Positioned(
        //     top: width * 0.19,
        //     right: width * 0.10,
        //     child: Image.asset(Assets.images.dartPNG)),
        // Positioned(
        //   top: width * 0.9,
        //   right: width * 0.12,
        //   child: Image.asset(Assets.images.firebasePNG),
        // ),
        // Positioned(
        //   top: width * 0.9,
        //   right: width * 0.12,
        //   child: Image.asset(Assets.images.nextjsPNG),
        // ),
        Positioned(
          top: width * 0.16,
          right: width * 0.08,
          child: Image.asset(
            Assets.images.nodejsPNG,
            width: width * 0.06,
            height: width * 0.058,
          ),
        ),
        Positioned(
          top: width * 0.08,
          left: 10,
          right: width * 0.12,
          child: Image.asset(
            Assets.images.swiftuiPNG,
            width: width * 0.06,
            height: width * 0.058,
          ),
        ),
        Positioned(
          top: width * 0.10,
          right: width * 0.09,
          child: Image.asset(
            Assets.images.xcodePNG,
            width: width * 0.06,
            height: width * 0.058,
          ),
        ),
        Positioned(
          top: width * 0.06,
          right: width * 0.016,
          child: Image.asset(
            Assets.images.dartPNG,
            width: width * 0.06,
            height: width * 0.058,
          ),
        ),
        Positioned(
          top: width * 0.04,
          left: width * 0.025,
          child: Container(
            width: width * 0.007,
            height: width * 0.007,
            decoration: const BoxDecoration(
                color: CustomColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        ),
        Positioned(
          top: width * 0.19,
          right: 1,
          child: Container(
            width: width * 0.007,
            height: width * 0.007,
            decoration: const BoxDecoration(
                color: CustomColors.purple,
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        ),
        Positioned(
          top: width * 0.28,
          left: width * 0.03,
          child: Container(
            width: width * 0.007,
            height: width * 0.007,
            decoration: const BoxDecoration(
                color: CustomColors.secondary,
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        ),
        Positioned(
          top: width * 0.01,
          right: 1,
          child: Container(
            width: width * 0.012,
            height: width * 0.012,
            decoration: const BoxDecoration(
                color: CustomColors.darkBackground,
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        )
      ],
    );
  }
}
