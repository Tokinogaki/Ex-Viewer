import 'package:eh_lib/eh_lib.dart';

import 'eh_constant.dart';
import 'eh_gallery.dart';
import 'model/model.dart' as model;
import 'util/client_ex.dart';

class EhSession {
  static final _instance = EhSession._();

  var client = ClientEx();

  get cookie => client.cookie;

  EhSession._() {
    // init ClientEx
    client.userAgent = USER_AGENT;
    client.referer = BASE_URL;
  }

  factory EhSession() {
    return _instance;
  }

  Future<bool> loggedIn() async {
    var list =
        await model.fetchGalleries(LIST_URL, 0, excludedCategories: EhCategory.include([EhCategories.AllCategory]));

    return list.length != 0;
  }

  Future loginWithCookie(String cookie) async {
    // assign all cookies
    client.cookie = cookie;
  }

  Future login(String user, String pass) async {
    // try login
    var cookies = await model.login(user, pass);
    if (cookies.isEmpty) return false;

    // assign preliminary cookies
    client.cookie = cookies.map((c) => '${c.name}=${c.value}').join(';');

    // try refresh the profile
    cookies.addAll(await model.refreshProfile());
    if (cookies.isEmpty) return false;

    // assign all cookies
    client.cookie = cookies.map((c) => '${c.name}=${c.value}').join(';');
  }

  Future logout() async => client.cookie = '';

  Future<List<EhGallery>> fetchGalleries(int page, {String keyword, int excludedCategories}) async {
    var list = await model.fetchGalleries(LIST_URL, page, keyword: keyword, excludedCategories: excludedCategories);
    await model.fetchGalleriesMeta(list);

    return list;
  }

  Future<List<EhGallery>> fetchFavourites(int page) async {
    var list = await model.fetchGalleries(FAVOURITE_URL, page);
    await model.fetchGalleriesMeta(list);

    return list;
  }
}
