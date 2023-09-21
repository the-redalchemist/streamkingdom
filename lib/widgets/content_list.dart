import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:transparent_image/transparent_image.dart';
import '../assets.dart';
import '../models/models.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Content>? contentList;
  final List<Tile>? tileList;
  final bool isOriginals;

  const ContentList(
      {Key? key,
      required this.title,
      this.contentList,
      this.isOriginals = false,
      this.tileList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tileList != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                title,
                style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              child: SizedBox(
                height: isOriginals ? 500.0 : 220,
                child: InfiniteCarousel.builder(
                  itemCount: tileList!.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final Tile? tile = tileList?[index];
                    return GestureDetector(
                      onTap: () => log("${tile!.name} / ${tile.url}"),
                      child: FadeInImage.memoryNetwork(
                        // height: 600,
                        // width: 400,
                        // height: isOriginals ? 600.0 : 200,
                        // width: isOriginals ? 400 : 160,
                        fit: BoxFit.contain,
                        imageErrorBuilder: (_, __, ___) {
                          //return
                          return Stack(children: <Widget>[
                            Image.asset(
                              Assets.netflixLogo0,
                              opacity: const AlwaysStoppedAnimation(.2),
                            ),
                            Center(
                                child: Text(
                                  tile!.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ]); //this is what will fill the Container in case error happened
                        },
                        placeholder: kTransparentImage,
                        image: tile?.imageUrl ??
                            "https://bs.to/public/images/cover/8688.jpg",
                      ),
                    );
                  },
                  itemExtent: isOriginals ? 300 : 160,
                  axisDirection: Axis.horizontal,
                  anchor: 0.0,
                  center: false,
                  velocityFactor: 1.0,
                  scrollBehavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      // Allows to swipe in web browsers
                      PointerDeviceKind.touch,
                      PointerDeviceKind.trackpad,
                      PointerDeviceKind.mouse,
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                title,
                style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              child: SizedBox(
                height: isOriginals ? 500.0 : 220,
                child: InfiniteCarousel.builder(
                  itemCount: contentList!.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final Content? content = contentList?[index];
                    return GestureDetector(
                      onTap: () => log(content.name),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: isOriginals ? 400.0 : 200,
                        width: isOriginals ? 300 : 160,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(content!.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  },
                  itemExtent: isOriginals ? 300 : 160,
                  axisDirection: Axis.horizontal,
                  anchor: 0.0,
                  center: false,
                  velocityFactor: 1.0,
                  scrollBehavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      // Allows to swipe in web browsers
                      PointerDeviceKind.touch,
                      PointerDeviceKind.trackpad,
                      PointerDeviceKind.mouse,
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
