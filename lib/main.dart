import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/screens/portfolio.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:url_strategy/url_strategy.dart';
// import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: CustomColors.primary,
    statusBarColor: CustomColors.primary,
  ));
  runApp(MaterialApp(
    theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        // primarySwatch: Colors.amber,
        primaryColor: CustomColors.primary,
        splashColor: CustomColors.primary,
        highlightColor: CustomColors.primary,
        useMaterial3: true),
    title: 'Udesh-dev',
    // showPerformanceOverlay: true,

    home: const Portfolio(),
    debugShowCheckedModeBanner: false,
  ));
}
