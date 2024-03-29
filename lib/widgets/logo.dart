import 'package:flutter/material.dart';
import 'package:portfolio/utils/Image_asset_constants.dart';
import 'package:portfolio/utils/breakpoints.dart';

class Logo extends StatelessWidget {
  final double width;
  final ScrollController scrollController;
  const Logo({required this.width, required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
            child: SelectableText(
              "Udesh Sharma",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            width: width >= Breakpoints.xlg
                ? width * 0.14
                : Breakpoints.xlg * 0.14,
            height: width >= Breakpoints.xlg
                ? 0.04 * width
                : 0.04 * Breakpoints.xlg),
      ),
    );
  }
}
