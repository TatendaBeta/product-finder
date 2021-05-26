import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productfinder/Components/pages/productDetails.dart';
import 'package:productfinder/Components/services/getDatabaseFile.dart';

class  Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_List = [
    // {
    //   "name": "Desktop",
    //   "picture": "images/gadgets/computer-all-in-one-png-7.png",
    //   "old_price": 22,
    //   "price": 35
    // },
    // {
    //   "name": "Camera",
    //   "picture": "images/gadgets/camera2.jpg",
    //   "old_price": 22,
    //   "price": 35
    // },
    // {
    //   "name": "Headphone",
    //   "picture": "images/gadgets/headphones.jpg",
    //   "old_price": 22,
    //   "price": 35
    // },
    // {
    //   "name": "Printers",
    //   "picture": "images/gadgets/hpprinter.jpg",
    //   "old_price": 22,
    //   "price": 35
    // },
    // {
    //   "name": "Speakers",
    //   "picture": "images/gadgets/muzilispeaker.jpg",
    //   "old_price": 22,
    //   "price": 35
    // },
    // {
    //   "name": "Watch",
    //   "picture": "images/gadgets/watch4.jpg",
    //   "old_price": 22,
    //   "price": 35
    // },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList()async{
    dynamic resultant = await DatabaseManager().getUsersList();
    if(resultant==null){
      print("Unable to retrieve");
    }else
      setState(() {
        product_List = resultant;
      });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_List.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_product(
            prod_name: product_List[index]['productName'],
            prod_picture: product_List[index]['Link'],
            // prod_details: product_List[index]['productDetails'],
            prod_price: int.parse(product_List[index]['productPrice']),
          );
        });
  }
}

class Single_product extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final String Link;
  final String productDetail;
  final int prod_price;

  Single_product(
      {this.prod_name, this.prod_picture, this.Link, this.prod_price, this.productDetail});

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
                      product_detail_newprice: "$prod_price",
                    ))),
            child: GridTile(
              footer: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.4),
                ),
                //
                child: ListTile(
                  leading: Text(
                    prod_name,
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 20),
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
              child: Image(
                image: NetworkImage(prod_picture),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
