import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
  );
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
        home: const HomePage(),
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
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Colors.black,
      body: ResponsiveBuilder(builder: (context, size) {
        return DefaultTextStyle(
          style: TextStyle(fontFamily: GoogleFonts.raleway().fontFamily),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  if (!size.isMobile)
                    SizedBox(
                      width: size.screenSize.width * 0.8,
                      height: 100,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: FlutterLogo(),
                                backgroundColor: Colors.white12,
                              ),
                              Text(
                                "Flutter Developer",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "LinkedIn / Github / Instagram",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  const CircleAvatar(
                    radius: 50,
                  ),
                  ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
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
                    child: const Text("Build Digital",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        tileMode: TileMode.clamp,
                        colors: [
                          Colors.white,
                          Colors.black26,
                          Color(0xffE1E1E1),
                          Colors.black26
                        ],
                      ).createShader(bounds);
                    },
                    child: const Text("Products ,brands and",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                  ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        tileMode: TileMode.clamp,
                        colors: [
                          Colors.white,
                          Colors.black26,
                          Color(0xffE1E1E1),
                          Colors.black26
                        ],
                      ).createShader(bounds);
                    },
                    child: const Text("experiences",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  )
                ]),
          ),
        );
      }),
    );
  }
}
