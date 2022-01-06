import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:zartek_sample/repositories/shared_prefs.dart';

class PhoneAuthenProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  PhoneAuthCredential? phoneAuthCredential;
  String? phone;
  String? verificationId;

  Future<void> verifyPhone(String countryCode, String mobile) async {
    phone = mobile;
    final PhoneCodeSent smsOTPSent = (String? verId, [int? forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone!,
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException except) {
            throw except;
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      final UserCredential user = await _auth.signInWithCredential(credential);
      final currentUser = _auth.currentUser;
      final _prefs = SharedPreferencesRepo.instance;
      _prefs.signIn(phone!, currentUser!.uid);
    } catch (e) {
      throw e;
    }
  }

  showError(error) {
    throw error.toString();
  }
}
