import 'dart:convert';

import 'package:html/parser.dart';

import '../eh_gallery.dart';
import '_api.dart' as api;

Future<List<EhGallery>> fetchGalleries(String url, int page, {String keyword, int excludedCategories}) async {
  var params = {};
  params['page'] = page;
  if (keyword != null) params['f_search'] = keyword;
  if (excludedCategories != null) params['f_cats'] = excludedCategories;

  var response = await api.list(url, params: params);
  if (response.statusCode != 200) return [];

  List<EhGallery> _parse(String html) {
    var galleries = parse(html).querySelectorAll('.gl3c');
    var info = parse(html).querySelectorAll('.gl2c');

    if (galleries.length != info.length) return [];

    var results = <EhGallery>[];

    for (var i = 0; i < galleries.length; i++) {
      var g = galleries[i];
      var f = info[i];

      var link = g.querySelector('a')?.attributes['href'];

      var m = RegExp(r'^.+\/g\/([0-9]+?)\/([0-z]+?)(\/|$)').firstMatch(link);
      if (m == null || m.groupCount != 3) continue;
      var gid = int.parse(m.group(1));
      var token = m.group(2);

      var favourite = f.querySelector('#posted_$gid')?.attributes['title']?.contains('Favorites');
      if (favourite == null) favourite = false;

      results.add(EhGallery(gid, token, link)..favourite = favourite);
    }

    return results;
  }

  return _parse(response.body);
}

Future<bool> fetchGalleriesMeta(List<EhGallery> info) async {
  if (info.length == 0) return false;

  var payload = {
    'method': 'gdata',
    'namespace': 1,
    'gidlist': info.map((g) => [g.gId, g.gToken]).toList(),
  };

  var responseRaw = await api.galleryInfoBatch(json.encode(payload));
  if (responseRaw.statusCode != 200) return false;

  var response = json.decode(responseRaw.body);
  if (response == null) return false;

  void _parse(response, List<EhGallery> info) {
    var i = 0;
    response['gmetadata']?.forEach((g) {
      var gid = g['gid'];

      // the response is normally sorted, but we check it once more
      var gi = (gid == info[i].gId) ? info[i] : info.firstWhere((b) => b.gId == gid);
      if (gi == null) return;

      gi.title = g['title'];
      gi.titleJpn = (g['title_jpn'] == '') ? null : g['title_jpn'];
      gi.category = g['category'];
      gi.thumb = g['thumb'];
      gi.uploader = g['uploader'];
      gi.postDate = DateTime.fromMillisecondsSinceEpoch(int.tryParse(g['posted']) * 1000 ?? 0);
      gi.fileCount = int.tryParse(g['filecount']) ?? 0;
      gi.rating = double.tryParse(g['rating']) ?? 0;
      gi.tags = List<String>.from(g['tags']);

      i++;
    });
  }

  _parse(response, info);
  return true;
}
