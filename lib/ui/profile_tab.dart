import 'package:eh_lib/eh_lib.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    void _clearOldCache() async {
      await DiskCache().keepCacheHealth();
      setState(() {});
    }

    void _clearAllCache() async {
      await DiskCache().clear();
      setState(() {});
    }

    void _logoutInternal() async {
      _clearAllCache();

      (await SharedPreferences.getInstance()).remove('ex_session_cookie');
      await EhSession().logout();
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage()));
    }

    void _logout() async {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text('Clear cache and log out from ExHentai?'),
            message: Text('You will be directed to the login page.'),
            cancelButton: CupertinoActionSheetAction(
              child: Text('Cancel'),
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text('Log out'),
                isDestructiveAction: true,
                onPressed: _logoutInternal,
              ),
            ],
          );
        },
      );
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: '',
        leading: null,
        middle: Text('My Profile'),
      ),
      child: CupertinoSettings(items: <Widget>[
        new CSHeader('Storage'),
        new CSControl(
          'Cache size',
          FutureBuilder<int>(
            future: DiskCache().cacheSize(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Text('${filesize(snapshot.data)}', style: TextStyle(fontSize: 14.0));
              else
                return CupertinoActivityIndicator();
            },
          ),
        ),
        new CSButton(CSButtonType.DESTRUCTIVE, "Clean up images viewed before the last week", _clearOldCache),
        new CSButton(CSButtonType.DESTRUCTIVE, "Clean up all cached images", _clearAllCache),
        new CSHeader('Session'),
        new CSButton(CSButtonType.DESTRUCTIVE, "Log out from ExHentai", _logout),
      ]),
    );
  }
}
