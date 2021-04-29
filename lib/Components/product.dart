import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productfinder/Components/pages/productDetails.dart';

class  Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_List = [
    {
      "name": "Desktop",
      "picture": "images/gadgets/computer-all-in-one-png-7.png",
      "old_price": 22,
      "price": 35
    },
    {
      "name": "Camera",
      "picture": "images/gadgets/camera2.jpg",
      "old_price": 22,
      "price": 35
    },
    {
      "name": "Headphones",
      "picture": "images/gadgets/headphones.jpg",
      "old_price": 22,
      "price": 35
    },
    {
      "name": "Printers",
      "picture": "images/gadgets/hpprinter.jpg",
      "old_price": 22,
      "price": 35
    },
    {
      "name": "Speakers",
      "picture": "images/gadgets/muzilispeaker.jpg",
      "old_price": 22,
      "price": 35
    },
    {
      "name": "Watch",
      "picture": "images/gadgets/watch4.jpg",
      "old_price": 22,
      "price": 35
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_List.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_product(
            prod_name: product_List[index]['name'],
            prod_picture: product_List[index]['picture'],
            prod_oldprice: product_List[index]['old_price'],
            prod_price: product_List[index]['price'],
          );
        });
  }
}

class Single_product extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final int prod_oldprice;
  final int prod_price;

  Single_product(
      {this.prod_name, this.prod_picture, this.prod_oldprice, this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: prod_name,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new ProductDetails(
                  // WE ARE PASSING VALUES OF PRODUCT TO THE PRODUCT DETAIL
                      product_detail_name: prod_name,
                      product_detail_picture: prod_picture,
                      product_detail_oldprice: "$prod_oldprice",
                      product_detail_newprice: "$prod_price",
                    ))),
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    prod_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(
                    "\$$prod_price",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 20),
                  ),
                ),
              ),
              child: Image.asset(
                prod_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
