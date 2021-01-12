import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widget/CustomTextField.dart';
import 'package:flutter_app/screens/constants.dart';

class LoginScreen extends StatelessWidget {
  static String id = "LoginScreen";

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("resources/images/icons/buyIcon.png"),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Text(
                          'Buy it',
                          style:
                              TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                        ))
                  ],
                )),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          CustomTextField(
            hint: 'Enter your E-mail',
            icon: Icons.email,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomTextField(
            hint: 'Enter your password',
            icon: Icons.lock,
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: FlatButton(
              onPressed: () {},
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
              Text(
                'Login',
                style: TextStyle(fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
