import 'package:html/parser.dart';

import '../eh_image.dart';
import '_api.dart' as api;

Future<List<EhImage>> fetchImagesMeta(int gId, String gToken, int page) async {
  var response = await api.images(gId, gToken, params: {'p': page});
  if (response.statusCode != 200) return null;

  List<EhImage> _parse(String html) {
    var images = parse(html).querySelectorAll('.gdtl');

    var results = List<EhImage>();

    images?.forEach((i) {
      var link = i.querySelector('a')?.attributes['href'];

      var thumb = i.querySelector('a > img')?.attributes['src'];

      var m = RegExp(r'^.+\/s\/([0-z]+?)\/([0-9]+?)-([0-9]+?)$').firstMatch(link);
      if (m == null || m.groupCount != 3) return null;

      var img = EhImage(int.parse(m.group(3)), m.group(1), int.parse(m.group(2)), link);
      img.thumb = thumb;

      results.add(img);
    });

    return results;
  }

  return _parse(response.body);
}

Future<String> getFullImage(int gId, String iToken, int page) async {
  var response = await api.viewImage(gId, iToken, page);
  if (response.statusCode != 200) return null;

  var image = parse(response.body).querySelector('#i3 > a > img');
  if (image == null) return null;

  //var width = RegExp(r'(;| |^)width: ?([0-9]+)px').firstMatch(image.attributes['style'])?.group(2) ?? '0';
  //var height = RegExp(r'(;| |^)height: ?([0-9]+)px').firstMatch(image.attributes['style'])?.group(2) ?? '0';

  return image.attributes['src'];
}
