import 'dart:collection';
import 'dart:math';

import 'package:eh_lib/src/eh_constant.dart';

import 'eh_image.dart';
import 'model/model.dart' as model;

class EhGallery {
  final int gId;
  final String gToken;
  final String url;

  bool favourite;
  String title;
  String titleJpn;
  String category;
  String thumb;
  String uploader;
  DateTime postDate;
  int fileCount;
  double rating;
  List<String> tags;

  var _cachedImages = SplayTreeMap<int, EhImage>();

  EhGallery(this.gId, this.gToken, this.url);

  Future<EhImage> getImage(int index) async {
    if (_cachedImages.containsKey(index)) return _cachedImages[index];

    // calculate the page it belongs to. Note that page number starts from 0.
    var page = index ~/ IMAGES_PER_PAGE;
    var pos = index % IMAGES_PER_PAGE;

    return (await fetchImages(page))[pos];
  }

  Future<List<EhImage>> fetchImages(int page) async {
    // calculate image indices
    var from = page * IMAGES_PER_PAGE;
    var to = min(fileCount - 1, (page + 1) * IMAGES_PER_PAGE - 1);

    // check cache
    var cached = (_cachedImages.firstKeyAfter(from - 1) == from) && (_cachedImages.lastKeyBefore(to + 1) == to);

    if (cached) {
      return _cachedImages.entries.skipWhile((kv) => kv.key < from).take(to - from + 1).map((kv) => kv.value).toList();
    } else {
      var result = await model.fetchImagesMeta(this.gId, this.gToken, page);

      int i = from;
      _cachedImages.addEntries(result.map((r) => MapEntry(i++, r)));

      return result;
    }
  }

  @override
  String toString() => '$gId/$gToken: ${titleJpn ?? title}';
}
