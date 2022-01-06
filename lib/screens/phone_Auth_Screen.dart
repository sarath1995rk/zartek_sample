import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/others/routes.dart';
import 'package:zartek_sample/providers/phone_auth_provider.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Mobile'),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone'),
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: verifyPhone, child: Text('Get Otp')),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Otp'),
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(onPressed: verifyOTP, child: Text('Submit')),
                ],
              ),
            ),
    );
  }

  void showSnackBar(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        elevation: 3.0,
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error Occured'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK!'),
          )
        ],
      ),
    );
  }

  Future<void> verifyPhone() async {
    try {
      setState(() {
        _loading = true;
      });
      await Provider.of<PhoneAuthenProvider>(context, listen: false)
          .verifyPhone('+91', '+91' + _phoneNumberController.text.toString())
          .then((_) {
        showSnackBar('otp send to ${_phoneNumberController.text}');
      }).catchError((e) {
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }

        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      _showErrorDialog(context, e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> verifyOTP() async {
    try {
      setState(() {
        _loading = true;
      });
      await Provider.of<PhoneAuthenProvider>(context, listen: false)
          .verifyOTP(_otpController.text)
          .then((_) {
        Navigator.of(context).pushReplacementNamed(kMainScreen);
      }).catchError((e) {
        setState(() {
          _loading = false;
        });
        String errorMsg = 'Cant authentiate you Right now, Try again later!';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      _showErrorDialog(context, e.toString());
    }
  }
}
