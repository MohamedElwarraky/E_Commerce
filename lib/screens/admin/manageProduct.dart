import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/admin/editProduct.dart';
import 'package:flutter_app/services/store.dart';
import 'package:flutter_app/widgets/customMenu.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.9),
                  itemCount: products.length,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTapUp: (details) async {
                            double left = details.globalPosition.dx;
                            double top = details.globalPosition.dy;
                            double right =
                                MediaQuery.of(context).size.width - left;
                            double bottom =
                                MediaQuery.of(context).size.height - top;
                            await showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                    left, top, right, bottom),
                                items: [
                                  CustomPopUpMenuItem(
                                    child: Text('Edit'),
                                    onClick: () {
                                      Navigator.pushNamed(
                                          context, EditProduct.id, arguments: products[index]);
                                    },
                                  ),
                                  CustomPopUpMenuItem(
                                    child: Text('Delete'),
                                    onClick: () {
                                      store.deleteProduct(products[index].pId);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ]);
                          },
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage(products[index].pLocation)),
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text('\$' + products[index].pPrice)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ));
            } else {
              return Center(child: Text('Loading...'));
            }
          }),
    );
  }
}


