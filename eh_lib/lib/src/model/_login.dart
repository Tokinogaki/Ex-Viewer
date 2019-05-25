import 'dart:io';

import '../util/cookie.dart';
import '_api.dart' as api;

/// Get login [Cookie] given [user] and [pass].
Future<List<Cookie>> login(String user, String pass) async {
  var response = await api.login(user, pass);

  if (response.statusCode != 200) return [];
  if (!response.headers.containsKey('set-cookie')) return [];

  var cookie_raw = response.headers['set-cookie'];
  if (!cookie_raw.contains('ipb_pass_hash')) return [];

  return parseCookieString(cookie_raw);
}

/// Get [Cookie] for the user's default profile.
Future<List<Cookie>> refreshProfile() async {
  var response = await api.profile();

  if (response.statusCode != 200) return [];
  if (!response.headers.containsKey("set-cookie")) return [];

  var cookie_raw = response.headers['set-cookie'];
  if (!cookie_raw.contains('sk')) return [];

  return parseCookieString(cookie_raw);
}
