import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/screens/admin/addProduct.dart';

class AdminHomeScreen extends StatelessWidget {
  static String id = 'AdminHomeScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text('Add Product'),
          ),
          RaisedButton(
            onPressed: () {
              //Navigator.pushNamed(context, ManageProducts.id);
            },
            child: Text('Edit Product'),
          ),
          RaisedButton(
            onPressed: () {
              //Navigator.pushNamed(context, OrdersScreen.id);
            },
            child: Text('View orders'),
          )
        ],
      ),
    );
  }
}