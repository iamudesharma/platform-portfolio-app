// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:portfolio/assets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
  );
  runApp(const MyApp());
}

var images = [
  Assets.logo.flutterSVG,
  Assets.logo.firebaseSVG,
  Assets.logo.figmaSVG,
  Assets.logo.androidSVG,
  Assets.logo.nodejsSVG,
  Assets.logo.webSolutionSVG,
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        material: (_, __) => MaterialAppData(),
        cupertino: (_, __) => CupertinoAppData(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    return PlatformScaffold(
      backgroundColor: Colors.white,
      body: ResponsiveBuilder(builder: (context, size) {
        return DefaultTextStyle(
          style: TextStyle(
              fontFamily: GoogleFonts.raleway().fontFamily,
              color: Colors.black),

          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                AppBar(
                  elevation: 00,
                  leading: const FlutterLogo().animate().slide(),
                  centerTitle: false,
                  title: const Text("Udesh Sharma").animate().slide(),
                  backgroundColor: Colors.transparent,
                  actions: [
                    size.isMobile
                        ? Icon(
                            Icons.menu,
                            color: Colors.black,
                          )
                        : Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text("Home").animate().slide(),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("Home").animate().slide(),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text("Home").animate().slide(),
                              ),
                            ],
                          ),
                  ],
                ),

                SizedBox(
                  height: size.screenSize.height * 0.1,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: size.screenSize.width * 0.6,
                    minWidth: size.screenSize.width * 0.4,
                  ),
                  width: 500,
                  child: Text(
                    "Udesh Sharma \nFlutter Developer\n Based in India",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(),
                ),

                Placeholder(
                  fallbackHeight: size.screenSize.height * 0.7,
                  fallbackWidth: 400,
                ).animate().fadeIn(),

                Divider(),
                SizedBox(
                  height: size.screenSize.height * 0.1,
                ),

                SelectableText(
                  "My Advantages",
                  style: Theme.of(context).textTheme.headlineMedium,
                )
                    .animate(
                        // delay: 400.ms,
                        )
                    .fadeIn()
                    .slide(),

                Wrap(
                  children: images.map((e) {
                    return ItemWidget(
                      path: e,
                    );
                  }).toList(),
                ),

                // SliverPadding(
                //   padding: EdgeInsets.only(left: size.screenSize.width * 0.1),
                //   sliver: SliverToBoxAdapter(
                //     child: SizedBox(
                //       height: size.screenSize.height * 0.1,
                //     ),
                //   ),
                // ),
                // SliverPadding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: size.screenSize.width * 0.1),
                //   sliver: SliverToBoxAdapter(
                //     child: SelectableText(
                //       "We specialize in crafting exceptional \ndigital experiences to help our \nclients achieve their business goals.",
                //       style: TextStyle(
                //         fontSize: 25,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //     ).animate().slide(),
                //   ),
                // ),
                // SliverToBoxAdapter(
                //   child: SizedBox(
                //     height: size.screenSize.height * 0.1,
                //   ),
                // ),
                // SliverPadding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: size.screenSize.width * 0.1),
                //   sliver: SliverToBoxAdapter(
                //     child: SelectableText(
                //       "Moblie App Design",
                //       style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                //           color: Colors.white, fontWeight: FontWeight.w700),
                //     ).animate().slide(),
                //   ),
                // ),
                // SliverToBoxAdapter(
                //   child: SizedBox(
                //     height: size.screenSize.height * 0.05,
                //   ),
                // ),
                // SliverPadding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: size.screenSize.width * 0.1),
                //   sliver: SliverGrid.builder(
                //     itemCount: 4,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: size.isMobile ? 1 : 2,
                //       crossAxisSpacing: 20,
                //       mainAxisSpacing: 20,
                //     ),
                //     itemBuilder: (context, index) {
                //       return const ItemWidget();
                //     },
                //   ),
                // )
              ],
            ),
          ),
          // child: Center(
          //   child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         // const SizedBox(
          //         //   height: kToolbarHeight,
          //         // ),
          //         // if (!size.isMobile)
          //         //   SizedBox(
          //         //     width: size.screenSize.width * 0.8,
          //         //     height: 100,
          //         //     child: Column(
          //         //       children: [
          //         //         Row(
          //         //           children: [
          //         //             const CircleAvatar(
          //         //               child: FlutterLogo(),
          //         //               backgroundColor: Colors.white12,
          //         //             ),
          //         //             const Text(
          //         //               "Flutter Developer",
          //         //               style: TextStyle(
          //         //                 fontSize: 15,
          //         //                 fontWeight: FontWeight.bold,
          //         //                 color: Colors.white70,
          //         //               ),
          //         //             ),
          //         //             const Spacer(),
          //         //             const Text(
          //         //               "LinkedIn / Github / Instagram",
          //         //               style: TextStyle(
          //         //                 fontSize: 15,
          //         //                 fontWeight: FontWeight.bold,
          //         //                 color: Colors.white70,
          //         //               ),
          //         //             ),
          //         //           ],
          //         //         ),
          //         //         const Divider(
          //         //           color: Colors.white,
          //         //         ),
          //         //       ],
          //         //     ),
          //         //   ),
          //         // const CircleAvatar(
          //         //   radius: 50,
          //         // ),
          //         // const SizedBox(
          //         //   height: 20,
          //         // ),
          //         // const Text("Hi , I'm Udesh Sharma 👋",
          //         //     style: TextStyle(
          //         //       fontSize: 16,
          //         //       fontWeight: FontWeight.bold,
          //         //       color: Colors.white,
          //         //     )),
          //         // const SizedBox(
          //         //   height: kToolbarHeight,
          //         // ),
          //         // ShaderMask(
          //         //   blendMode: BlendMode.srcATop,
          //         //   shaderCallback: (Rect bounds) {
          //         //     return const LinearGradient(
          //         //       begin: Alignment.topLeft,
          //         //       end: Alignment.bottomRight,
          //         //       tileMode: TileMode.mirror,
          //         //       colors: [
          //         //         Colors.white,
          //         //         Colors.black26,
          //         //         // Color(0xffE1E1E1),
          //         //         // Colors.black26
          //         //       ],
          //         //     ).createShader(bounds);
          //         //   },
          //         //   child: const Text("Build Digital",
          //         //       style: TextStyle(
          //         //         fontSize: 40,
          //         //         fontWeight: FontWeight.bold,
          //         //         color: Colors.white,
          //         //       )),
          //         // ),
          //         // ShaderMask(
          //         //   blendMode: BlendMode.srcATop,
          //         //   shaderCallback: (Rect bounds) {
          //         //     return const LinearGradient(
          //         //       tileMode: TileMode.clamp,
          //         //       colors: [
          //         //         Colors.white,
          //         //         Colors.black26,
          //         //         Color(0xffE1E1E1),
          //         //         Colors.black26
          //         //       ],
          //         //     ).createShader(bounds);
          //         //   },
          //         //   child: const Text("Products ,brands and",
          //         //       style: TextStyle(
          //         //         fontSize: 40,
          //         //         fontWeight: FontWeight.bold,
          //         //         color: Colors.white,
          //         //       )),
          //         // ),
          //         // ShaderMask(
          //         //   blendMode: BlendMode.srcATop,
          //         //   shaderCallback: (Rect bounds) {
          //         //     return const LinearGradient(
          //         //       tileMode: TileMode.clamp,
          //         //       colors: [
          //         //         Colors.white,
          //         //         Colors.black26,
          //         //         Color(0xffE1E1E1),
          //         //         Colors.black26
          //         //       ],
          //         //     ).createShader(bounds);
          //         //   },
          //         //   child: const Text("experiences",
          //         //       style: TextStyle(
          //         //         fontSize: 40,
          //         //         fontWeight: FontWeight.bold,
          //         //         color: Colors.white,
          //         //       )),
          //         // )
          //       ]),
          // ),
        );
      }),
    );
  }
}

class ItemWidget extends StatefulWidget {
  const ItemWidget({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;
  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        // setState(() {
        //   isHover = true;
        // });
      },
      onExit: (event) => setState(() {
        isHover = false;
      }),
      onHover: (event) {
        setState(() {
          isHover = true;
        });
      },
      child: Center(
        child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.3),
            radius: 100,
            child: SvgPicture.asset(
              widget.path,
              fit: BoxFit.cover,
              height: 100,
              width: 100,
              colorFilter: isHover
                  ? null
                  : ColorFilter.mode(Colors.transparent, BlendMode.saturation),
            ).animate(
              onPlay: (controller) {
                if (isHover) {
                  controller.repeat();
                } else {
                  controller.stop();
                }
              },
            ).shake()),
      ).animate().slide(),
    );
  }
}
