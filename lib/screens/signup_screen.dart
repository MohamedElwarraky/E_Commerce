import 'package:flutter/services.dart';
import 'package:flutter_app/provider/modalHud.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/widgets/CustomLogo.dart';
import 'package:flutter_app/widgets/CustomTextField.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  // To track form in which state
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  static String id = "SignUpScreen";

  String userName, email, password;
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: KMainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModalHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                CustomLogo(),
                SizedBox(
                  height: height * 0.1,
                ),
                CustomTextField(
                  onClick: (value) {
                    this.userName = value;
                  },
                  hint: 'Enter your name',
                  icon: Icons.perm_identity,
                ),
                SizedBox(
                  height: height * 0.02,
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
                  child: Builder(
                    builder: (context) => FlatButton(
                      onPressed: () async {
                        final modalHUd = Provider.of<ModalHud>(context, listen: false);
                        modalHUd.changeIsLoading(true);
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          try {
                            final result = await auth.signup(
                                email: this.email, password: this.password);
                            modalHUd.changeIsLoading(false);
                            Navigator.pushNamed(context, LoginScreen.id);
                          } on PlatformException catch (e) {
                            modalHUd.changeIsLoading(false);
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)));
                          }
                        }
                        modalHUd.changeIsLoading(false);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.black,
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Do have an account ? ',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16, decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
      ),
    );
  }
}
