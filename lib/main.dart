import 'package:eh_lib/eh_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/home_page.dart';
import 'ui/login_page.dart';

void main() async {
  var prefs = await SharedPreferences.getInstance();

  debugPrint('saved session: ${prefs.getString('ex_session_cookie')}');
  await EhSession().loginWithCookie(prefs.getString('ex_session_cookie') ?? '');

  var loggedIn = await EhSession().loggedIn();

  runApp(
    new CupertinoApp(
      home: loggedIn ? HomePage() : LoginPage(),
    ),
  );
}
