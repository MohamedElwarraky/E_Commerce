import 'package:flutter/material.dart';
import 'package:flutter_app/provider/modalHud.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ModalHud>(
      create: (context) => ModalHud(),
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id : (context)=> LoginScreen(),
          SignupScreen.id : (context)=> SignupScreen()
        },
      ),
    );
  }

}