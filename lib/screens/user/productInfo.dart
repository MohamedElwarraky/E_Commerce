import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/provider/cartItem.dart';
import 'package:flutter_app/screens/user/cart_screen.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'PrductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage(product.pLocation),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
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
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.pName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Description: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                product.pDescription,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$ ${product.pPrice}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Material(
                                  color: KMainColor,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                _quantity.toString(),
                                style: TextStyle(
                                  fontSize: 50,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ClipOval(
                                child: Material(
                                  color: KMainColor,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_quantity > 1) {
                                          _quantity--;
                                        }
                                      });
                                    },
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Builder(
                      builder: (context) => RaisedButton(
                        onPressed: () {
                          addToCart(context, product);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        color: KMainColor,
                        child: Text(
                          'Add to cart'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exsit = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart == product) {
        exsit = true;
        break;
      }
    }
    if (exsit) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('You \'ve added this item before.')));
    } else {
      cartItem.addProduct(product);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Added to cart')));
    }
  }
}
