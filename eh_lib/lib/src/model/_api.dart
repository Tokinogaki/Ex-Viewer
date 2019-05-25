import 'package:http/http.dart';

import '../eh_constant.dart';
import '../eh_session.dart';
import '../util/url.dart';

/// Login with given [user] and [pass].
Future<Response> login(String user, String pass) => EhSession().client.post(LOGIN_POST_URL, body: {
      'UserName': user,
      'PassWord': pass,
      'CookieDate': '1',
      'Privacy': '1',
    });

/// Refresh current profile to the default one.
Future<Response> profile() => EhSession().client.get(PROFILE_URL);

/// Get a list of [Gallery].
Future<Response> list(String url, {Map params}) => EhSession().client.get(url + mapToQueryString(params));

/// Official API: get the detailed info of a list of [Gallery].
Future<Response> galleryInfoBatch(String json) => EhSession().client.post(API_URL, body: json);

Future<Response> images(int gid, String token, {Map params}) =>
    EhSession().client.get('$GALLERY_URL/$gid/$token/${mapToQueryString(params)}');

Future<Response> viewImage(int gid, String token, int page) =>
    EhSession().client.get('$IMAGE_URL/$token/$gid-$page');
