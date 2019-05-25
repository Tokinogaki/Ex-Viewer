import 'package:eh_lib/eh_lib.dart';
import 'package:ex_viewer/ui/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  bool _loggingIn = false;

  void _performLogin() async {
    setState(() {
      _loggingIn = true;
    });

    await EhSession().login(this.username, this.password);
    var result = await EhSession().loggedIn();

    setState(() {
      _loggingIn = false;
    });

    if (result) {
      debugPrint('${EhSession().cookie}');

      var prefs = await SharedPreferences.getInstance();
      prefs.setString('ex_session_cookie', EhSession().cookie);

      setState(() {
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomePage()));
      });
    } else {
      debugPrint('login failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: '',
        leading: null,
        middle: Text('Log in to ExHentai'),
      ),
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    if (_loggingIn) {
      return Center(child: CupertinoActivityIndicator(radius: 16.0));
    } else {
      return ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 26.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Container(
                    height: 40,
                    child: CupertinoTextField(
                      autofocus: true,
                      autocorrect: false,
                      decoration: BoxDecoration(
                          color: CupertinoColors.extraLightBackgroundGray, borderRadius: BorderRadius.circular(5.0)),
                      clearButtonMode: OverlayVisibilityMode.editing,
                      onChanged: (_) => this.username = _,
                      placeholder: 'Username',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Container(
                    height: 40,
                    child: CupertinoTextField(
                      autocorrect: false,
                      decoration: BoxDecoration(
                          color: CupertinoColors.extraLightBackgroundGray, borderRadius: BorderRadius.circular(5.0)),
                      clearButtonMode: OverlayVisibilityMode.editing,
                      onChanged: (_) => this.password = _,
                      placeholder: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CupertinoButton(
                    child: Text('Login'),
                    color: CupertinoColors.activeBlue,
                    onPressed: () => _performLogin(),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
  }
}
