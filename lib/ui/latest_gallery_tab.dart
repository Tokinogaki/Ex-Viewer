import 'package:eh_lib/eh_lib.dart';
import 'package:ex_viewer/ui/widget/base_gallery_list_view.dart';
import 'package:flutter/cupertino.dart';

class LatestGalleryTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LatestGalleryTabViewState();
}

class LatestGalleryTabViewState extends BaseGalleryListViewState<LatestGalleryTab> {
  LatestGalleryTabViewState() : super(title: Text('Latest'));

  @override
  Future<List<EhGallery>> itemFetcher(int page) {
    debugPrint('itemFetcher: latest, $page');
    return EhSession().fetchGalleries(
      page,
      keyword: '',
      //excludedCategories: EhCategory.include(
      //  [
      //    EhCategories.NonH,
      //  ],
      //),
    );
  }
}
