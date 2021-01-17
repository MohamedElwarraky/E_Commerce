import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/screens/user/productInfo.dart';

Widget productView(String category, List<Product> _Products) {
  List<Product> products = getProductByCategory(category, _Products);

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.9),
    itemCount: products.length,
    itemBuilder: (context, index) =>
        Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(products[index].pLocation)),
                ),
                Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
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
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}

List<Product> getProductByCategory(String category, List<Product> _Product) {
  List<Product> products = [];
  try {
    for (var product in _Product) {
      if (product.pCategory == category) {
        products.add(product);
      }
    }
  }on Error catch(ex){
    print(ex);
  }

  return products;
}
