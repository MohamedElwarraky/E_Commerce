import 'package:flutter/material.dart';
import 'package:flutter_app/provider/adminMode.dart';
import 'package:flutter_app/provider/cartItem.dart';
import 'package:flutter_app/provider/modalHud.dart';
import 'package:flutter_app/screens/admin/addProduct.dart';
import 'package:flutter_app/screens/admin/admin_screen.dart';
import 'package:flutter_app/screens/admin/editProduct.dart';
import 'package:flutter_app/screens/admin/manageProduct.dart';
import 'package:flutter_app/screens/user/cart_screen.dart';
import 'package:flutter_app/screens/user/home_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:flutter_app/screens/user/productInfo.dart';
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
          ChangeNotifierProvider<CartItem>(
              create: (context) => CartItem()
          ),
        ],
        child: MaterialApp(
          initialRoute: LoginScreen.id,
          routes: {
            ProductInfo.id: (context) => ProductInfo(),
            LoginScreen.id: (context) => LoginScreen(),
            SignupScreen.id: (context) => SignupScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            AdminHomeScreen.id: (context) => AdminHomeScreen(),
            AddProduct.id: (context) => AddProduct(),
            ManageProduct.id: (context) => ManageProduct(),
            EditProduct.id: (context) => EditProduct(),
            CartScreen.id: (context) => CartScreen(),
          },
        ),
      );
  }
}