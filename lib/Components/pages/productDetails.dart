import 'package:flutter/material.dart';
import 'package:productfinder/Components/pages/locationPage.dart';
import 'package:productfinder/Components/pages/viewLocation.dart';
import 'package:productfinder/Components/services/urlLauncherServices.dart';

class ProductDetails extends StatefulWidget {
  final String product_detail_name;
  final String product_detail_picture;
  final String product_detail_newprice;

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_picture,
      this.product_detail_newprice});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search App"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 330,
            color: Colors.black,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image(
                    image:NetworkImage(widget.product_detail_picture),
              )),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.product_detail_name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Text("\$ ${widget.product_detail_newprice}", style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),


          // ==================Second  buy button=============

      Row(
        children: [
          Expanded(
            child: MaterialButton(
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapsDemo()));
              },
              child: Text("View Location"),
            ),
          ),

          IconButton(icon: Icon(Icons.call), color: Colors.indigo,onPressed: (){
            Utils.openPhoneCall(phoneNumber: '+263774539645');
          }),
          IconButton(icon: Image.asset("images/icons/whatsApp.png", height: 400, width: 400,fit: BoxFit.contain,),color: Colors.indigo, onPressed: (){
            launchWhatsApp(number: "+263774539645", message: "hello i am interested in your product");
          })
        ],
      ),
      ListTile(
        title: Text("Product Details"),
        subtitle: Text("The best way to learn flutter: 1. Java Head First - this is to learn the basics of programming, focus on classes, methods, variables. Also Java is pretty much exactly the same as Dart which is the language used in Flutter so don't worry, if you know Java you know Dart. You can buy it here if you want: https://amzn.to/2GVAdFC 2. Setup Flutter - for this I would suggest checking out this article that I feel goes through the basics. And as a sidenote first time I tried to set this up I was completely lost so don't worry if you don't understand, just push through."),
      ),
          Divider(),
          SizedBox(height: 5),

          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(15, 5, 5, 5), child: Text("Product Name"),),
              Padding(padding: EdgeInsets.all(5), child: Text(widget.product_detail_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),)
            ],
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(15, 5, 5, 5), child: Text("Brand"),),
              Padding(padding: EdgeInsets.all(5), child: Text("Brand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),)
            ],
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(15, 5, 5, 5), child: Text("Condition"),),
              Padding(padding: EdgeInsets.all(5), child: Text("Good", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),)
            ],
          ),
      // ===SIMILAR PRODUCTS===
        Divider(),
          Padding(padding: EdgeInsets.all(10), child: Text("Similar Products", style: TextStyle(fontSize: 16, ),),),
          Container(height: 300, child: SimilarProducts())
        ],


      ),
    );
  }
}


class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  var product_List = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_List.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_single_product(
            prod_name: product_List[index]['productName'],
            prod_picture: product_List[index]['Link'],
            prod_price: product_List[index]['productPrice'],
          );
        });
  }
}

class Similar_single_product extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final int prod_price;

  Similar_single_product(
      {this.prod_name, this.prod_picture, this.prod_price});

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

