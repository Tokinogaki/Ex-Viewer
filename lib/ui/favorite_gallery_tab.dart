import 'package:eh_lib/eh_lib.dart';
import 'package:ex_viewer/ui/widget/base_gallery_list_view.dart';
import 'package:flutter/cupertino.dart';

class FavouriteGalleryTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavouriteGalleryTabViewState();
}

class FavouriteGalleryTabViewState extends BaseGalleryListViewState<FavouriteGalleryTab> {
  FavouriteGalleryTabViewState() : super(title: Text('Favourites'));

  @override
  Future<List<EhGallery>> itemFetcher(int page) {
    debugPrint('itemFetcher: fav, $page');
    return EhSession().fetchFavourites(page);
  }
}
