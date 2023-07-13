// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'package:portfolio/assets.dart';
import 'package:portfolio/utils/breakpoints.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:portfolio/widgets/footer.dart';
import 'package:portfolio/widgets/lower_container.dart';
import 'package:portfolio/widgets/nav_bar.dart';
import 'package:portfolio/widgets/upper_container.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

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
        child: Scrollbar(
          controller: scrollController,
          child: WebSmoothScroll(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 130),
                      UpperContainer(width: width),
                      LowerContainer(
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
                  NavBar(
                    width: width,
                    projectsKey: projectsKey,
                    skillsKey: skillsKey,
                    intrestsKey: intrestsKey,
                    key: homeKey,
                    scrollController: scrollController,
                  ).animate().fade().slide(),
                ],
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
  }) : super(key: key);
  final GlobalKey<State<StatefulWidget>> projectsKey;

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
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(seconds: 10),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) {},
              scrollDirection: Axis.horizontal,
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
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      onHover: (event) {
        setState(() {
          isHovering = true;
        });
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
          if (isHovering)
            Container(
              height: 400,
              width: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.7),
              ),
              child: Center(
                child: Text(widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    )),
              ),
            ).animate().fade().flip(),
        ],
      ),
    );
  }
}
