// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:get/get.dart';
import 'package:glowstone/glowstone.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import 'package:portfolio/assets.dart';
import 'package:portfolio/utils/breakpoints.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/footer.dart';
import 'package:portfolio/widgets/lower_container.dart';
import 'package:portfolio/widgets/nav_bar.dart';
import 'package:portfolio/widgets/upper_container.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  late final List<Map> intrests;
  late final GlobalKey intrestsKey;
  late final GlobalKey skillsKey;
  late final GlobalKey projectsKey;
  late final GlobalKey homeKey;
  late final ScrollController scrollController;
  late final RxBool showFloatingButton;

  Path path = Path();

  @override
  void initState() {
    intrestsKey = GlobalKey();
    skillsKey = GlobalKey();
    homeKey = GlobalKey();
    projectsKey = GlobalKey();
    scrollController = ScrollController();
    showFloatingButton = false.obs;

    intrests = [
      {
        'intrest': 'Beatbox',
        'color': CustomColors.primary,
        'textColor': CustomColors.darkBackground,
      },
      {
        'intrest': 'Chess',
        'color': CustomColors.brightBackground,
        'textColor': CustomColors.primary,
      },
      {
        'intrest': 'Soccer',
        'color': CustomColors.primary,
        'textColor': CustomColors.darkBackground,
      },
      {
        'intrest': 'Listening to music',
        'color': CustomColors.brightBackground,
        'textColor': CustomColors.primary,
      },
      {
        'intrest': 'Watching movies',
        'color': CustomColors.brightBackground,
        'textColor': CustomColors.primary,
      },
      {
        'intrest': 'Math',
        'color': CustomColors.primary,
        'textColor': CustomColors.darkBackground,
      },
      {
        'intrest': 'Learning English',
        'color': CustomColors.brightBackground,
        'textColor': CustomColors.primary,
      },
      {
        'intrest': 'Solving Problems',
        'color': CustomColors.primary,
        'textColor': CustomColors.darkBackground,
      },
    ];

    scrollController.addListener(() {
      if (scrollController.offset >= Breakpoints.floatingButton) {
        showFloatingButton.value = true;
      } else {
        showFloatingButton.value = false;
      }
    });
    super.initState();
  }

  ValueNotifier<Offset> position = ValueNotifier<Offset>(Offset(10, 30));
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: ObxValue<RxBool>(
        (data) => Visibility(
          visible: data.value,
          child: FloatingActionButton(
              onPressed: () => scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOut),
              backgroundColor: CustomColors.primary,
              child: const Icon(Icons.arrow_upward,
                  color: CustomColors.darkBackground)),
        ),
        showFloatingButton,
      ),
      body: Container(
        color: CustomColors.brightBackground,
        width: width,
        child: ImprovedScrolling(
          scrollController: scrollController,
          onScroll: (scrollOffset) => debugPrint(
            'Scroll offset: $scrollOffset',
          ),
          onMMBScrollStateChanged: (scrolling) => debugPrint(
            'Is scrolling: $scrolling',
          ),
          onMMBScrollCursorPositionUpdate:
              (localCursorOffset, scrollActivity) => debugPrint(
            'Cursor position: $localCursorOffset\n'
            'Scroll activity: $scrollActivity',
          ),
          enableMMBScrolling: true,
          enableKeyboardScrolling: true,
          enableCustomMouseWheelScrolling: true,
          mmbScrollConfig: const MMBScrollConfig(
              // customScrollCursor:
              //     useSystemCursor ? null : const DefaultCustomScrollCursor(),
              ),
          keyboardScrollConfig: KeyboardScrollConfig(
            arrowsScrollAmount: 250.0,
            homeScrollDurationBuilder: (currentScrollOffset, minScrollOffset) {
              return const Duration(milliseconds: 100);
            },
            endScrollDurationBuilder: (currentScrollOffset, maxScrollOffset) {
              return const Duration(milliseconds: 2000);
            },
          ),
          customMouseWheelScrollConfig: const CustomMouseWheelScrollConfig(
            scrollAmountMultiplier: 2.0,
          ),
          child: Scrollbar(
            controller: scrollController,
            child: ScrollConfiguration(
              behavior: const CustomScrollBehaviour(),
              child: WebSmoothScroll(
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          MouseRegion(
                              // cursor: position != Offset.zero
                              //     ? SystemMouseCursors.click
                              //     : SystemMouseCursors.precise,
                              onExit: (event) {
                                position.value = event.localPosition;
                              },
                              onEnter: (event) {
                                position.value = event.localPosition;
                              },
                              onHover: (event) {
                                position.value = event.localPosition;

                                print(position.value);
                              },
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      NavBar(
                                        width: width,
                                        projectsKey: projectsKey,
                                        skillsKey: skillsKey,
                                        intrestsKey: intrestsKey,
                                        key: homeKey,
                                        scrollController: scrollController,
                                      ).animate().fade().slide(),
                                      UpperContainer(width: width),
                                    ],
                                  ),
                                  // if (position.value.dx != 10 &&
                                  //     position.value.dy != 30)
                                  ValueListenableBuilder(
                                      valueListenable: position,
                                      builder: (context, offset, child) {
                                        return AnimatedContainer(
                                          curve: Curves.bounceInOut,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Positioned(
                                            left: offset.dx,
                                            top: offset.dy,
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          )
                                              .animate(
                                                  autoPlay: true,
                                                  adapter: ValueAdapter(
                                                    animated: true,
                                                    position.value.distance,
                                                  ))
                                              .move()
                                              .followPath(
                                                  rotate: true,
                                                  path: Path.from(
                                                      path.shift(offset))),
                                        );
                                      }),
                                ],
                              )),
                          LowerContainer(
                              scrollController: scrollController,
                              width: width,
                              intrests: intrests,
                              intrestsKey: intrestsKey,
                              skillsKey: skillsKey),
                          const Align(
                            alignment: Alignment.center,
                            child: SelectableText('Projects',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.primary,
                                )),
                          ),
                          ProjectListWidget(
                            scrollController: scrollController,
                            projectsKey: projectsKey,
                          ),
                          Container(
                            width: width,
                            height: 0.1,
                            color: CustomColors.gray,
                          ),
                          Footer(
                            width: width,
                            scrollController: scrollController,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

final projectList = [
  ProjectModel(image: [
    Assets.images.treeved1WEBP,
    Assets.images.treeved2WEBP,
    Assets.images.treeved3WEBP,
  ], title: "TreeVed"),
  ProjectModel(image: [
    Assets.images.mypaylist1PNG,
    Assets.images.mypaylist2PNG,
  ], title: "MyPayList"),
  ProjectModel(
    image: [
      Assets.images.wings1PNG,
      Assets.images.wings2PNG,
    ],
    title: "Wings Dating App",
  ),
];

class ProjectListWidget extends StatefulWidget {
  const ProjectListWidget({
    Key? key,
    required this.projectsKey,
    required this.scrollController,
  }) : super(key: key);
  final GlobalKey<State<StatefulWidget>> projectsKey;
  final ScrollController scrollController;

  @override
  State<ProjectListWidget> createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.projectsKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: CarouselSlider(
            // disableGesture: true,
            items: List.generate(
                projectList.length,
                (index) => ProjectCard(
                      images: projectList[index].image,
                      title: projectList[index].title,
                    )).toList(),
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 0.6,
              initialPage: 0,
              pauseAutoPlayOnTouch: true,
              enableInfiniteScroll: true,
              reverse: true,

              // autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(seconds: 10),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              pageSnapping: true,
              onPageChanged: (index, reason) {},
              scrollDirection: Axis.horizontal,
              onScrolled: (value) {
                // print(value);
              },
            )),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    Key? key,
    required this.images,
    required this.title,
  }) : super(key: key);

  final List<String> images;
  final String title;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  // bool isHovering = false;

  ValueNotifier<bool> isHovering = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        isHovering.value = true;
      },
      onExit: (event) {
        isHovering.value = false;
      },
      onHover: (event) {
        isHovering.value = true;
      },
      child: Stack(
        children: [
          Container(
            height: 400,
            width: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: CustomColors.primary,
                width: 2,
              ),
            ),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 400,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                onPageChanged: (index, reason) {},
                scrollDirection: Axis.horizontal,
              ),
              itemCount: widget.images.length,
              itemBuilder: (context, index, realIndex) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(widget.images[index]),
                    )),
              ),
            ),
          ).animate().fade(),
          ValueListenableBuilder(
              valueListenable: isHovering,
              builder: (BuildContext context, bool value, Widget? child) {
                if (isHovering.value) {
                  return Container(
                    height: 400,
                    width: 600,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: Center(
                      child: Text(widget.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          )),
                    ),
                  ).animate().fade().flip();
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ],
      ),
    );
  }
}

class CustomScrollBehaviour extends MaterialScrollBehavior {
  const CustomScrollBehaviour();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
        return Scrollbar(
          controller: details.controller,
          thumbVisibility: true,
          child: child,
        );
      case TargetPlatform.windows:
        return Scrollbar(
          controller: details.controller,
          thumbVisibility: true,
          radius: Radius.zero,
          thickness: 16.0,
          hoverThickness: 16.0,
          showTrackOnHover: true,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}
