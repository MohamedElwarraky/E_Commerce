import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/user/cart_screen.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/store.dart';
import 'package:flutter_app/widgets/productView.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = Auth();
  FirebaseUser _loggedUser;
  int tabBarIndex = 0;
  final store = Store();
  int bottomBarIndex = 0;

  List<Product> _Product = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomBarIndex,
              fixedColor: KMainColor,
              onTap: (value) {
                setState(() {
                  bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                    title: Text('Text'), icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    title: Text('Text'), icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    title: Text('Text'), icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    title: Text('Text'), icon: Icon(Icons.person)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: KMainColor,
                onTap: (value) {
                  setState(() {
                    tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text('Jackets',
                      style: TextStyle(
                        color: tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                        fontSize: tabBarIndex == 0 ? 16 : null,
                      )),
                  Text('Pants',
                      style: TextStyle(
                        color: tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                        fontSize: tabBarIndex == 1 ? 16 : null,
                      )),
                  Text('T-shirts',
                      style: TextStyle(
                        color: tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                        fontSize: tabBarIndex == 2 ? 16 : null,
                      )),
                  Text('Shoes',
                      style: TextStyle(
                        color: tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                        fontSize: tabBarIndex == 3 ? 16 : null,
                      )),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                jacketView(),
                productView(kPants, _Product),
                productView(kTshirts, _Product),
                productView(kShoes, _Product)
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: Icon(Icons.shopping_cart),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    _loggedUser = await auth.getUser();
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
        stream: store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              products.add(Product(
                  pId: doc.documentID,
                  pName: data[kProductName],
                  pPrice: data[kProductPrice],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
            // store the data in _Product with a referance
            _Product = [...products];
            products.clear();
            return productView(kJackets, _Product);
          } else {
            return Center(child: Text('Loading...'));
          }
        });
  }
}
