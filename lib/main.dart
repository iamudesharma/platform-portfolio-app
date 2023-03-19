import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = ThemeData(
      brightness: Brightness.dark,
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: Color(0xff127EFB),
        scaffoldBackgroundColor: Color(0xff11111),
      ),
    );

    return PlatformProvider(
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: true,
        iosUseZeroPaddingForAppbarPlatformIcon: true,
      ),
      builder: (context) => PlatformApp(
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        title: 'Flutter Platform Widgets',
        home: HomePage(),
        material: (_, __) => MaterialAppData(
          theme: ThemeData(scaffoldBackgroundColor: Colors.black),
        ),
        cupertino: (_, __) => CupertinoAppData(
          theme: const CupertinoThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xff11111),
            primaryColor: Color(0xff127EFB),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTextStyle(
        style: TextStyle(fontFamily: GoogleFonts.raleway().fontFamily),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                ),
                ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.mirror,
                      colors: [
                        Colors.white,
                        Colors.black26,
                        // Color(0xffE1E1E1),
                        // Colors.black26
                      ],
                    ).createShader(bounds);
                  },
                  child: Text("Build Digital",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      tileMode: TileMode.clamp,
                      colors: [
                        Colors.white,
                        Colors.black26,
                        Color(0xffE1E1E1),
                        Colors.black26
                      ],
                    ).createShader(bounds);
                  },
                  child: Text("Products ,brands and",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                ShaderMask(
                  blendMode: BlendMode.srcATop,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      tileMode: TileMode.clamp,
                      colors: [
                        Colors.white,
                        Colors.black26,
                        Color(0xffE1E1E1),
                        Colors.black26
                      ],
                    ).createShader(bounds);
                  },
                  child: Text("experiences",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
