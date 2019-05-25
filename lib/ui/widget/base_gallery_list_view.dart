import 'package:eh_lib/eh_lib.dart';
import 'package:ex_viewer/ui/widget/gallery_row_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class BaseGalleryListViewState<View extends StatefulWidget> extends State<View>
    with AutomaticKeepAliveClientMixin {
  final Text title;
  List<Widget> floatWidgets;

  var galleries = <EhGallery>[];
  var _currentPage = -1;

  var _isUpdating = false;
  var _endReached = false;
  var _hasError = false;

  BaseGalleryListViewState({@required this.title});

  Future<List<EhGallery>> itemFetcher(int page);

  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _fetchNextPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 200 < _scrollController.position.maxScrollExtent) return;

      _fetchNextPage();
    });
  }

  void _fetchNextPage() async {
    if (_endReached) return;
    if (_isUpdating) return;
    _isUpdating = true;

    var results = await itemFetcher(++_currentPage);

    debugPrint('_fetchNextPage: P=$_currentPage, ${results?.length} items obtained.');

    if (results == null) {
      _hasError = true;
      _currentPage--;
    }
    if (results.length == 0) _endReached = true;

    setState(() {
      galleries.addAll(results);
      _isUpdating = false;
    });
  }

  Future onRefresh() async {
    _currentPage = -1;
    _endReached = false;
    _hasError = false;

    var results = await itemFetcher(++_currentPage);

    debugPrint('_onRefresh: ${results?.length} items obtained.');

    if (results == null) {
      _hasError = true;
      _currentPage--;
    }
    if (results.length == 0) _endReached = true;

    setState(() {
      galleries.clear();
      galleries.addAll(results);
    });
  }

  @override
  Widget build(BuildContext context) {
    var tab = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          heroTag: 'nav_$title',
          largeTitle: this.title,
        ),
      ],
    );

    if (floatWidgets != null) tab.slivers.addAll(floatWidgets);

    if (galleries.length > 0) {
      tab.slivers.addAll([
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < galleries.length)
                  return GalleryRowItem(gallery: galleries[index]);
                else if (_hasError || _endReached)
                  return Container(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => _hasError ? _fetchNextPage() : null,
                          child: Text(
                            _hasError
                                ? 'Error occoured when fetching new items. Tap on me to retry.'
                                : 'You have reached the end of the list.',
                            style: TextStyle(color: CupertinoColors.inactiveGray, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                else // loading
                  return Container(height: 60, child: CupertinoActivityIndicator(radius: 12));
              },
              childCount: galleries.length + 1,
            ),
          ),
        )
      ]);
    }
    //else if (_hasError)
    else {
      tab.slivers.add(SliverFillRemaining(child: CupertinoActivityIndicator(radius: 12)));
    }

    // add tap to top
    return Stack(
      children: <Widget>[
        tab,
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          height: MediaQuery.of(context).padding.top,
          child: GestureDetector(
            excludeFromSemantics: true,
            onTap: () => _scrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                ),
          ),
        ),
      ],
    );
  }
}
