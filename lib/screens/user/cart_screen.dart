import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/provider/cartItem.dart';
import 'package:flutter_app/screens/user/productInfo.dart';
import 'package:flutter_app/services/store.dart';
import 'package:flutter_app/widgets/customMenu.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight -
                    appBarHeight -
                    statusBarHeight -
                    (screenHeight * 0.08),
                child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTapUp: (details) {
                            showCustomMenu(context, details, products[index]);
                          },
                          child: Container(
                            height: screenHeight * 0.15,
                            color: KSecondaryColor,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(products[index].pLocation),
                                  radius: screenHeight * 0.15 / 2,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                products[index].pName,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '\$ ${products[index].pPrice}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }

            return Container(
              height: screenHeight -
                  (screenHeight * 0.08) -
                  statusBarHeight -
                  appBarHeight,
              child: Center(
                child: Text('Cart is empty!'),
              ),
            );
          }),
          Builder(
            builder: (context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight * 0.08,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(
                      10,
                    ),
                  ),
                ),
                onPressed: () {
                  showCustomDialog(products, context);

                },
                child: Text(
                  'Order'.toUpperCase(),
                ),
                color: KMainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomMenu(context, details, product) async {
    double left = details.globalPosition.dx;
    double top = details.globalPosition.dy;
    double right = MediaQuery.of(context).size.width - left;
    double bottom = MediaQuery.of(context).size.height - top;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, right, bottom),
        items: [
          CustomPopUpMenuItem(
            child: Text('Edit'),
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
            },
          ),
          CustomPopUpMenuItem(
            child: Text('Delete'),
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
            },
          ),
        ]);
  }

  void showCustomDialog(products, context) async {
    var price = getTotalPrice(products);
    String address = '';
    AlertDialog alert = AlertDialog(
      actions: [
        MaterialButton(
          onPressed: () {
            try {
              Store store = Store();
              store.storeOrders(
                  {kTotallPrice: price, kAddress: address}, products);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Ordered successfully'),
              ));
              Navigator.pop(context);
            } catch (ex) {
              print(ex);
            }
          },
          child: Text('Confirm'),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        )
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(
          hintText: 'Enter your address',
        ),
      ),
      title: Text('Total price = \$ $price'),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
