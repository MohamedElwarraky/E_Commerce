import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/widgets/CustomLogo.dart';
import 'package:flutter_app/widgets/CustomTextField.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  // To track form in which state
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  static String id = "LoginScreen";

  String email, password;
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            CustomLogo(),
            SizedBox(
              height: height * 0.1,
            ),
            CustomTextField(
              onClick: (value) {
                this.email = value;
              },
              hint: 'Enter your E-mail',
              icon: Icons.email,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            CustomTextField(
              onClick: (value) {
                this.password = value;
              },
              hint: 'Enter your password',
              icon: Icons.lock,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: FlatButton(
                onPressed: () {
                  if (_globalKey.currentState.validate()) {
                    _globalKey.currentState.save();
                    auth.signIn(email: this.email, password: this.password);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.black,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Don\'t have an account ? ',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignupScreen.id);
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 16, decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
