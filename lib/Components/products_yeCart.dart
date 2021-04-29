import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Productyecart extends StatefulWidget {
  @override
  _ProductyecartState createState() => _ProductyecartState();
}

class _ProductyecartState extends State<Productyecart> {
  var product_cart_list = [
    {
      "name": "Desktop",
      "picture": "images/gadgets/computer-all-in-one-png-7.png",
      "price": 35,
      "condition": "Good"
    },
    {
      "name": "Camera",
      "picture": "images/gadgets/camera2.jpg",
      "price": 35,
      "condition": "Better"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: product_cart_list.length,
        itemBuilder: (context, index) {
          return Product_cart_products(
            cart_prod_name: product_cart_list[index]["name"],
            cart_prod_picture: product_cart_list[index]["picture"],
            cart_prod_price: product_cart_list[index]["price"],
            cart_prod_condition: product_cart_list[index]["condition"],
          );
        });
  }
}

class Product_cart_products extends StatelessWidget {
  final String cart_prod_name;
  final String cart_prod_picture;
  final String cart_prod_condition;
  final int cart_prod_price;

  Product_cart_products(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_condition});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(cart_prod_picture),
        title: Text(cart_prod_name),
        subtitle: Column(
          children: [
            Row(children: [
              SizedBox(width: 20),
              Expanded(child: Text("Price")),
              SizedBox(width: 20),
              Expanded(child: Text("\$$cart_prod_price"))
            ],),
            Row(children: [
              SizedBox(width: 20),
              Expanded(child: Text("Condition")),
              SizedBox(width: 20),
              Expanded(child: Text(cart_prod_condition))
            ],)
          ],
        ),
      ),
    );
  }
}
