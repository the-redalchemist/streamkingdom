import 'dart:developer';

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:streamkingdom/cubits/app_bar/ThemeProvider.dart';
import 'package:streamkingdom/models/header_content_model.dart';
import 'package:transparent_image/transparent_image.dart';
import '../assets.dart';
import '../models/content_model.dart';
import 'package:streamkingdom/widgets/widgets.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  final HeaderContent? headerContent;
  const ContentHeader({Key? key, required this.featuredContent, this.headerContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(
        featuredContent: featuredContent,
        headerContent: headerContent,
      ),
      desktop: _ContentHeaderDesktop(
        featuredContent: featuredContent,
        headerContent: headerContent,
      ),
    );
  }
}

class _ContentHeaderMobile extends StatefulWidget {
  final Content featuredContent;
  final HeaderContent? headerContent;
  const _ContentHeaderMobile({Key? key, required this.featuredContent, this.headerContent})
      : super(key: key);

  @override
  State<_ContentHeaderMobile> createState() => _ContentHeaderMobileState();
}

class _ContentHeaderMobileState extends State<_ContentHeaderMobile> {
  // late VideoPlayerController _videoPlayerController;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Baum");
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          AnimatedCrossFade(
              firstChild: const Padding(
                padding: EdgeInsets.only(top: 70),
              ),
              secondChild: Container(
                height: 500.0,
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  // height: 600,
                  // width: 400,
                  imageErrorBuilder: (_, __, ___) {
                    //return
                    return Stack(children: <Widget>[
                      Image.asset(
                        Assets.netflixLogo0,
                        opacity: const AlwaysStoppedAnimation(.2),
                      ),
                      Center(
                          child: Text(
                            widget.headerContent!.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ]); //this is what will fill the Container in case error happened
                  },
                  placeholder: kTransparentImage,
                  image: widget.headerContent?.posterUrl ??
                      "https://bs.to/public/images/cover/8688.jpg",
                ),
              ),
              crossFadeState: isPlaying
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 400)),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: isPlaying ? 450 : 500.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.gradientColor , Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
          ),
          // Positioned(
          //   bottom: 110,
          //   child: SizedBox(
          //     width: 250,
          //     child: Image.asset(widget.featuredContent.titleImageUrl!),
          //   ),
          // ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 120,
            child: Center(
              child: Text(
                widget.headerContent!.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2.0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                  icon: Icons.add,
                  title: 'List',
                  onTap: () => log('MyList'),
                ),
                const _PlayButton(),
                VerticalIconButton(
                  icon: Icons.info_outline,
                  title: 'Info',
                  onTap: () => throw StateError("This is a Dart test exception error."),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;
  final HeaderContent? headerContent;
  const _ContentHeaderDesktop({Key? key, required this.featuredContent, this.headerContent})
      : super(key: key);

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  // late VideoPlayerController _videoPlayerController;
  // bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    // _videoPlayerController =
    //     VideoPlayerController.network(widget.featuredContent.videoUrl!)
    //       ..initialize().then((_) => setState(() {}))
    //       ..setVolume(0)
    //       ..play();
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    super.dispose();
  }

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // print(widget.headerContent);
    return GestureDetector(
      // onTap: () => _videoPlayerController.value.isPlaying
      //     ? _videoPlayerController.pause()
      //     : _videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: 2.344,
            child: FadeInImage.memoryNetwork(
              // height: 600,
              // width: 400,
              fit: BoxFit.cover,
              imageErrorBuilder: (_, __, ___) {
                //return
                return Stack(children: <Widget>[
                  Image.asset(
                    Assets.netflixLogo0,
                    opacity: const AlwaysStoppedAnimation(.2),
                  ),
                  Center(
                      child: Text(
                        widget.headerContent!.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ]); //this is what will fill the Container in case error happened
              },
              placeholder: kTransparentImage,
              image: widget.headerContent?.posterUrl ??
                  "https://bs.to/public/images/cover/8688.jpg",
            ),
          ),
          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: 2.344,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Theme.of(context).colorScheme.gradientColor, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.headerContent!.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 250,
                //   child: Ima ge.asset(widget.featuredContent.titleImageUrl!),
                // ),
                const SizedBox(
                  height: 15,
                ),
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: FadingEdgeScrollView.fromSingleChildScrollView(
                      shouldDisposeScrollController: true,
                      gradientFractionOnStart: 1,
                      gradientFractionOnEnd: 0.9,
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Text(
                          widget.headerContent!.description!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(2.0, 4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const _PlayButton(),
                    const SizedBox(
                      width: 16,
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(25, 10, 30, 10),
                        ),
                      ),
                      onPressed: () => throw StateError("This is a Dart exception error."),
                      icon: const Icon(
                        Icons.info_outline,
                        size: 30,
                      ),
                      label: const Text(
                        'More Info',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: !Responsive.isDesktop(context)
            ? MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(15, 5, 20, 5),
              )
            : MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(25, 10, 30, 10),
              ),
      ),
      onPressed: () {
        log('Play');
        Navigator.of(context).pushNamed("/NavScreens");
      },
      icon: const Icon(
        Icons.play_arrow,
        size: 30,
        color: Colors.black,
      ),
      label: const Text(
        'Play',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
