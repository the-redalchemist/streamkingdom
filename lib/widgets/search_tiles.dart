import 'package:flutter/material.dart';
import '../models/models.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:streamkingdom/assets.dart';

class SearchTile extends StatefulWidget {
  final List<Tile> tileList;

  SearchTile({
    Key? key,
    required this.tileList,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  @override
  Widget build(BuildContext context) {
    //fetchImage();
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      itemCount: (widget.tileList.length <= 40) ? widget.tileList.length : 40,
      itemBuilder: (BuildContext context, int index) {
        final String tile = widget.tileList[index].name;
        return GestureDetector(
          onTap: () => print(tile),
          child: FadeInImage.memoryNetwork(
            height: 600,
            width: 400,
            imageErrorBuilder: (_, __, ___) {
              //return
              return Stack(children: <Widget>[
                Image.asset(
                  Assets.netflixLogo0,
                  opacity: const AlwaysStoppedAnimation(.2),
                ),
                Center(
                    child: Text(
                  tile,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ]); //this is what will fill the Container in case error happened
            },
            placeholder: kTransparentImage,
            image: widget.tileList[index].imageUrl ??
                "https://bs.to/public/images/cover/8688.jpg",
          ),
          // child: Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 8),
          //   height: 200,
          //   width: 130,
          //   child: CachedNetworkImage(
          //     imageUrl:
          //     widget.tileList[index].imageUrl ?? "https://bs.to/serie/Parallel-Worlds-Parallels",
          //         //"https://bs.to/serie/Parallel-Worlds-Parallels",
          //     //fetchImage(widget.tileList[index].url).toString(),
          //     placeholder: (context, url) =>
          //         const CircularProgressIndicator(
          //           color: Colors.red,
          //         ),
          //     errorWidget: (context, url, error) => Icon(Icons.error),
          //   ),

          // child: FutureBuilder(
          //   future: fetchImage(widget.tileList[index].url),
          //   builder: (BuildContext context, image) {
          //     if (image.hasData) {
          //       return CachedNetworkImage(
          //         imageUrl: image.data.toString(),
          //         placeholder: (context, url) => const CircularProgressIndicator(),
          //         errorWidget: (context, url, error) => Icon(Icons.error),
          //       );
          //       // return FadeInImage.memoryNetwork(
          //       //   placeholder: kTransparentImage,
          //       //   image: image.data.toString(),
          //       // ); // image is ready
          //     } else {
          //       return FadeInImage.assetNetwork(
          //         placeholder: 'assets/gif/Netflix_LoadTime.gif',
          //         image: 'https://picsum.photos/250?image=9',
          //       ); // placeholder
          //     }
          //   },
          // ),
        );
      },
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          // mainAxisExtent: 530,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
