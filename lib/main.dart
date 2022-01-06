import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/others/routes.dart';
import 'package:zartek_sample/providers/cart_provider.dart';
import 'package:zartek_sample/providers/food_provider.dart';
import 'package:zartek_sample/providers/google_signin_provider.dart';
import 'package:zartek_sample/providers/phone_auth_provider.dart';
import 'package:zartek_sample/repositories/shared_prefs.dart';
import 'package:zartek_sample/screens/cart_screen.dart';
import 'package:zartek_sample/screens/main_screen.dart';
import 'package:zartek_sample/screens/home_screen.dart';
import 'package:zartek_sample/screens/phone_Auth_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesRepo.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => PhoneAuthenProvider()),
        ChangeNotifierProvider(create: (context) => FoodProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider())
      ],
      child: MaterialApp(
        title: 'Zartek Sample',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          kMainScreen: (context) => MainScreen(),
          kPhoneAuthScreen: (context) => PhoneAuthScreen(),
          kCartScreen: (context) => CartScreen()
        },
      ),
    );
  }
}
