import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productfinder/Components/pages/productDetails.dart';
import 'package:productfinder/Components/services/getDatabaseFile.dart';


class CloudFirestoreSearch extends StatefulWidget {


  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  var product_List = [];

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


  String productName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                productName = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (productName != "" && productName != null)
            ? FirebaseFirestore.instance
            .collection('products')
            .where("searchKey", arrayContains: productName)
            .snapshots()
            : FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.docs[index];
              return Card(
                child: InkWell(
                  onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetails(
                    // WE ARE PASSING VALUES OF PRODUCT TO THE PRODUCT DETAIL
                    product_detail_name: product_List [index]['productName'],
                    product_detail_picture: product_List [index]['Link'],
                    product_detail_newprice: product_List[index]['productPrice']
                  ))),
                  child: Row(
                    children: <Widget>[
                      Image.network(
                        data['Link'],
                        width: 150,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        data['productName'],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}