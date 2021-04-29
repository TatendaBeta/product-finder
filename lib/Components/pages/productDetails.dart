import 'package:flutter/material.dart';
import 'package:productfinder/Components/pages/viewLocation.dart';

class ProductDetails extends StatefulWidget {
  final String product_detail_name;
  final String product_detail_picture;
  final String product_detail_oldprice;
  final String product_detail_newprice;

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_picture,
      this.product_detail_oldprice,
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
                child: Image.asset(widget.product_detail_picture),
              ),
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
                          child: Text(
                        "${widget.product_detail_oldprice}",
                        style: TextStyle(
                             fontSize: 20, decoration: TextDecoration.lineThrough),
                      )),
                      Expanded(
                        child: Text("${widget.product_detail_newprice}", style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),


          // ===== Size Wuantity and Color Buttomn=====
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Size"),
                        content: Text("Choose the Size"),
                        actions: [
                          MaterialButton(onPressed: (){Navigator.of(context).pop(context);}, child: Text("Close"),)
                        ],
                      );
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text("Size")),
                      Expanded(child: Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  onPressed: (){
                   showDialog(context: context, builder: (context){
                     return AlertDialog(
                       title: Text("Color"),
                       content: Text("Choose Color"),
                       actions: [
                         MaterialButton(onPressed: (){
                           Navigator.of(context).pop(context);
                         }, child: Text("Close"),)
                       ],
                     );
                   });
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text("Color")),
                      Expanded(child: Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  color: Colors.white,
                  textColor: Colors.grey,
                  onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Qty"),
                        content: Text("Choose Quantity"),
                        actions: [
                          MaterialButton(onPressed: (){
                            Navigator.of(context).pop(context);
                          }, child: Text("Close"),)
                        ],
                      );
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text("Qty")),
                      Expanded(child: Icon(Icons.arrow_drop_down))
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ==================Second  buy button=============

      Row(
        children: [
          Expanded(
            child: MaterialButton(
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LocationDetail()));
              },
              child: Text("View Location"),
            ),
          ),

          IconButton(icon: Icon(Icons.call), color: Colors.indigo,onPressed: (){}),
          IconButton(icon: Icon(Icons.email),color: Colors.indigo, onPressed: (){})
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
  var product_List = [
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
          return Similar_single_product(
            prod_name: product_List[index]['name'],
            prod_picture: product_List[index]['picture'],
            prod_oldprice: product_List[index]['old_price'],
            prod_price: product_List[index]['price'],
          );
        });
  }
}

class Similar_single_product extends StatelessWidget {
  final String prod_name;
  final String prod_picture;
  final int prod_oldprice;
  final int prod_price;

  Similar_single_product(
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

