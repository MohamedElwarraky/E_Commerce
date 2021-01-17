import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_app/services/store.dart';

class OrdersScreen extends StatelessWidget {
  static String id  = 'OrderScreen';
  final Store store = Store();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(

        stream: store.loadOrders(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Center(
              child: Text('There is no orders'),
            );
          }else{
            List<Order> orders = [];
            for(var doc in snapshot.data.documents){
              orders.add(
                Order(
                    doc.data[kTotallPrice],
                    doc.data[kAddress]
                )
              );
            }
            return ListView.builder(
              itemCount: orders.length,
                itemBuilder: (context, index){
                  return Text(orders[index].totlalPrice.toString());
                }
            );
          }
        },
      ),
    );
  }
}
