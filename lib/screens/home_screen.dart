import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/others/routes.dart';
import 'package:zartek_sample/providers/google_signin_provider.dart';
import 'package:zartek_sample/resources/assets.dart';
import 'package:zartek_sample/widgets/login_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 180,
                    width: 100,
                    child: Image.asset(
                      kFirebaseLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  LoginButton(kGoogleLogo, Colors.blue, 'Google', () async {
                    setState(() {
                      _loading = true;
                    });
                    final _prov = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    final val = await _prov.googleLogIn();
                    if (val) {
                      Navigator.of(context).pushNamed(kMainScreen);
                    } else {
                      setState(() {
                        _loading = false;
                      });
                    }
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  LoginButton(kPhoneLogo, Colors.lightGreen[400]!, 'Phone',
                      () async {
                    Navigator.of(context).pushNamed(kPhoneAuthScreen);
                  })
                ],
              ),
      ),
    );
  }
}
