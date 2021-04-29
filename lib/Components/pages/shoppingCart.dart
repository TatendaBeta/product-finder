import 'package:flutter/material.dart';
import 'package:productfinder/Components/products_yeCart.dart';

class Shopping_cart extends StatefulWidget {
  @override
  _Shopping_cartState createState() => _Shopping_cartState();
}

class _Shopping_cartState extends State<Shopping_cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text("Shopping Cart"),
        centerTitle: true,
        backgroundColor: Colors.indigo,

        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){}),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(child: ListTile(
              title: Text("Total:"),
              subtitle: Text("\$200"),
            )),
            Expanded( child: MaterialButton(
              onPressed: (){},
              color: Colors.indigo,
              child: Text("Checkout", style: TextStyle(color: Colors.white),),
            ))
          ],
        ),
      ),
      body: Productyecart(),
    );
  }
}
