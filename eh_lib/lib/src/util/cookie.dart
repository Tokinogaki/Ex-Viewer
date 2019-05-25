import 'dart:io';

List<Cookie> parseCookieString(String cookies) =>
    RegExp(r'(.*?=.*?)($|,(?! ))').allMatches(cookies).map((c) => Cookie.fromSetCookieValue(c.group(1))).toList();
