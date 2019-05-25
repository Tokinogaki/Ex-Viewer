import 'package:ex_viewer/ui/favorite_gallery_tab.dart';
import 'package:ex_viewer/ui/profile_tab.dart';
import 'package:ex_viewer/ui/search_tab.dart';
import 'package:flutter/cupertino.dart';

import 'latest_gallery_tab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('Latest')),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), title: Text('Favourites')),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('Search')),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), title: Text('Profile')),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return LatestGalleryTab();
          case 1:
            return FavouriteGalleryTab();
          case 2:
            return SearchTab();
          case 3:
            return ProfileTab();
        }
      },
    );
  }
}
