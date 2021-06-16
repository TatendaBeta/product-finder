import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:productfinder/Components/pages/productDetails.dart';
import 'package:productfinder/Components/services/DataController.dart';
import 'package:productfinder/Components/services/getDatabaseFile.dart';


class search2trial extends StatefulWidget {
  @override
  _search2trialState createState() => _search2trialState();
}

class _search2trialState extends State<search2trial> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExecuted = false;
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



  @override
  Widget build(BuildContext context) {
    Widget searchedData(){
      return ListView.builder(itemCount: snapshotData.docs.length,
      itemBuilder: (BuildContext context, int index){
        return InkWell(
          onTap: (){
            // Get.to(ProductDetails(),
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetails(
                product_detail_name: product_List [index]['productName'],
                product_detail_picture: product_List [index]['Link'],
                product_detail_newprice: product_List[index]['productPrice'])));

          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(snapshotData.docs[index].data()['Link']),
            ),

            title: Text(snapshotData.docs[index].data()['productName']),
            subtitle: Text(snapshotData.docs[index].data()['productName']),
          ),
        );
      },
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.clear), backgroundColor: Colors.indigo,onPressed: (){
        isExecuted=false;
      }),

      appBar: AppBar(
        backgroundColor: Colors.indigo,
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val){
              return IconButton(icon: Icon(Icons.search), onPressed: (){
                val.queryData(searchController.text).then((value){
                  snapshotData = value;

                  setState(() {
                    isExecuted = true;
                  });
                });
              });
            },
          )
        ],

        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search for product",
            hintStyle: TextStyle(color: Colors.white)
          ),
          controller: searchController,
        ),
      ),

      body: isExecuted ? searchedData(): Container (
        child: Center(
          child: Text("Search Data"),
        ),
      ),
    );
  }
}
