import 'package:eh_lib/eh_lib.dart';
import 'package:ex_viewer/ui/widget/base_gallery_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widget/sticky_app_bar_delegate.dart';

class SearchTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchTabViewState();
}

class SearchTabViewState extends BaseGalleryListViewState<SearchTab> {
  String keyword = '';

  SearchTabViewState() : super(title: Text('Search'));

  @override
  List<Widget> get floatWidgets => <Widget>[
        SliverPersistentHeader(
          pinned: false,
          floating: false,
          delegate: StickyAppBarDelegate(
            minHeight: 50,
            maxHeight: 50,
            child: Container(
              decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray, borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.search,
                      color: CupertinoColors.inactiveGray,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: CupertinoTextField(
                          autofocus: false,
                          autocorrect: false,
                          clearButtonMode: OverlayVisibilityMode.editing,
                          onSubmitted: _performSearch,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ];

  void _performSearch(String text) {
    setState(() {
      galleries.clear();
    });
    setState(() {
      keyword = text;
      onRefresh();
    });
  }

  @override
  Future<List<EhGallery>> itemFetcher(int page) {
    debugPrint('itemFetcher: P=$page, KW="$keyword"');
    return EhSession().fetchGalleries(page, keyword: keyword);
  }
}
