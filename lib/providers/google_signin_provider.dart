import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek_sample/repositories/shared_prefs.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final _prefs = SharedPreferencesRepo.instance;

  GoogleSignInAccount? _user;

  Future<bool> googleLogIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return false;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;

    final _credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    try {
      final details =
          await FirebaseAuth.instance.signInWithCredential(_credential);
      if (details.user != null) {
        print(details.user);

        _prefs.signIn(_user!.email, _user!.id);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      _prefs.signOut();
      return true;
    } catch (e) {
      return false;
    } finally {}
  }
}
