import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/provider/adminMode.dart';
import 'package:flutter_app/provider/modalHud.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/widgets/CustomLogo.dart';
import 'package:flutter_app/widgets/CustomTextField.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'admin_screen.dart';

class LoginScreen extends StatelessWidget {
  // To track form in which state
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  static String id = "LoginScreen";

  String email, password;
  final auth = Auth();

  final adminPassword = 'Admin1234';

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
                      validate(context);
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
                    // To make its content responsive with user
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeState(true);
                        },
                        child: Text(
                          'I\'m an admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? KMainColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeState(false);
                        },
                        child: Text(
                          'I\'m a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !Provider.of<AdminMode>(context).isAdmin
                                ? KMainColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context) async {
    final modalHUd = Provider.of<ModalHud>(context, listen: false);
    modalHUd.changeIsLoading(true);

    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context).isAdmin) {
        if (password == adminPassword) {
          try {
            final result =
                await auth.signIn(email: this.email, password: this.password);
            modalHUd.changeIsLoading(false);
            Navigator.pushNamed(context, AdminHomeScreen.id);
          } on PlatformException catch (e) {
            modalHUd.changeIsLoading(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          modalHUd.changeIsLoading(false);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Something went wrong')));
        }
      } else {
        try {
          final result =
              await auth.signIn(email: this.email, password: this.password);
          modalHUd.changeIsLoading(false);
          Navigator.pushNamed(context, HomeScreen.id);
        } on PlatformException catch (e) {
          modalHUd.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    modalHUd.changeIsLoading(false);
  }
}
