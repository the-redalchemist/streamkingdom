import 'dart:ui';
import 'package:flutter/material.dart';
import '../languages/languages.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cubits.dart';
import '../data/data.dart';

class HomeScreen extends StatefulWidget {
  final List<Tile>? popularList;
  final List<Tile>? trendingDayList;
  final List<Tile>? trendingWeekList;
  final HeaderContent? headerContent;
  final List<dynamic>? frontLists;

  const HomeScreen({Key? key,
    this.popularList,
    this.trendingDayList,
    this.trendingWeekList,
    this.headerContent,
    this.frontLists})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        BlocProvider.of<AppBarCubit>(context)
            .setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    // print(widget.frontLists);
    // print(widget.headerContent);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(
              scrollOffset: scrollOffset,
            );
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            // Allows to swipe in web browsers
            PointerDeviceKind.touch,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.mouse,
          },
        ),
        slivers: [
          if (widget.headerContent != null)
            SliverToBoxAdapter(
                child: ContentHeader(
                  featuredContent: sintelContent,
                  headerContent: widget.headerContent,
                )),
          // const SliverPadding(
          //   padding: EdgeInsets.only(top: 20),
          //   sliver: SliverToBoxAdapter(
          //     child: Previews(
          //         key: PageStorageKey('previews'),
          //         title: 'Previews',
          //         contentList: previews),
          //   ),
          // ),
          if (widget.frontLists != null)
            for (var element in widget.frontLists!)
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 20),
                sliver: SliverToBoxAdapter(
                  child: ContentList(
                    key: const PageStorageKey('popular'),
                    // title: Languages
                    //     .of(context)
                    //     ?.popularTitle ?? "",
                    title: element['title'],
                    tileList: element["value"],
                  ),
                ),
              ),
          if (widget.popularList != null)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 20),
              sliver: SliverToBoxAdapter(
                child: ContentList(
                  key: const PageStorageKey('popular'),
                  title: Languages
                      .of(context)
                      ?.popularTitle ?? "",
                  tileList: widget.popularList,
                ),
              ),
            ),
          if (widget.trendingDayList != null)
            SliverToBoxAdapter(
              child: ContentList(
                key: const PageStorageKey('trendingDay'),
                title: Languages
                    .of(context)
                    ?.trendingDayTitle ??
                    "Trending  today",
                tileList: widget.trendingDayList,
              ),
            ),
          if (widget.trendingWeekList != null)
            SliverToBoxAdapter(
              child: ContentList(
                key: const PageStorageKey('trendingWeek'),
                title: Languages
                    .of(context)
                    ?.trendingWeekTitle ??
                    "Trending  this week",
                tileList: widget.trendingWeekList,
                isOriginals: true,
              ),
            ),
          SliverToBoxAdapter(
            child: ContentList(
              key: const PageStorageKey('originals'),
              title: "Netflix Originals",
              contentList: originals,
              isOriginals: true,
            ),
          ),
        ],
      ),
    );
  }
}
