import 'package:flutter/material.dart';
import 'package:flutter_app/provider/adminMode.dart';
import 'package:flutter_app/provider/modalHud.dart';
import 'package:flutter_app/screens/admin/addProduct.dart';
import 'package:flutter_app/screens/admin/admin_screen.dart';
import 'package:flutter_app/screens/user/home_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ModalHud>(
              create: (context) => ModalHud()
          ),
          ChangeNotifierProvider<AdminMode>(
              create: (context) => AdminMode()
          ),
        ],
        child: MaterialApp(
          initialRoute: LoginScreen.id,
          routes: {
            LoginScreen.id: (context) => LoginScreen(),
            SignupScreen.id: (context) => SignupScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            AdminHomeScreen.id: (context) => AdminHomeScreen(),
            AddProduct.id: (context) => AddProduct()
          },
        ),
      );
  }
}