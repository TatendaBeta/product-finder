import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:productfinder/Components/horizontal_listview.dart';
import 'package:productfinder/Components/pages/login.dart';
import 'package:productfinder/Components/pages/search.dart';
import 'package:productfinder/Components/pages/search2Trial.dart';
import 'package:productfinder/Components/pages/shoppingCart.dart';
import 'package:productfinder/Components/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
// triaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaalll
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//

// end ehhhhhhhhhhhhhheeeeeeeeeeeeeeeeeeeeeeeeeeeeereeeeeeeeeeeeeeee

  void signOutGoogle() async{
    await googleSignIn.signOut();
    print("User Sign Out");
  }


  @override
  Widget build(BuildContext context) {



    Widget image_Carousel = Container(
      height: 200,

      child: Carousel(
        boxFit: BoxFit.cover,
        animationDuration: Duration(milliseconds: 1000),
        animationCurve: Curves.fastOutSlowIn,
        dotSize: 2,
        indicatorBgPadding: 6,
        autoplay: false,
        images: [
          AssetImage("images/gadgets/camera2.jpg"),
          AssetImage("images/gadgets/laptop2.png"),
          AssetImage("images/gadgets/hpprinter.jpg"),
          AssetImage("images/gadgets/watch4.jpg"),
          AssetImage("images/gadgets/tv2.png"),
          AssetImage("images/gadgets/camera2.jpg")
        ],
      ),

    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Search App"),
        centerTitle: true,
        backgroundColor: Colors.indigo,


        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>search2trial()));
          }),
          IconButton(icon: Icon(Icons.favorite), onPressed: (){
            //-------------------------- Directs to favorites ----------------------------------
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Shopping_cart()));
          })
        ],
      ),

      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            UserAccountsDrawerHeader(accountName: Text("TatendaBeta"), accountEmail: Text("bwizbwoi@gmail.com"), currentAccountPicture: GestureDetector(
              child: CircleAvatar(backgroundImage: AssetImage("images/beta.jpeg"),),
            ),),

            InkWell(
                onTap: (){},
                child: ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home)
                )),


            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Shopping_cart()));
              },
              child: ListTile(
                title: Text("Favourites"),
                leading: Icon(Icons.favorite),
              ),
            ),

            Divider(),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.help, color: Colors.blue,),
              ),
            ),

            InkWell(
              onTap: (){
                signOutGoogle();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
              },
              child: ListTile(
                title: Text("LogOut"),
                leading: Icon(Icons.logout, color: Colors.blue,),
              ),
            ),

          ],
        ),
      ),
      body: ListView(
        children: [
          //image_Carousel,
//  HROIZONTAL LIST VIEW CATEGORIES
          Padding(padding: EdgeInsets.all(8), child: Text("Categories"),),
          Container(height: 100,child: HorizontalList()),

          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Available Products"),
          ),
          // grid view of available products
          Container(constraints: BoxConstraints(
            maxHeight: 500,
          ),child: Products())
        ],
      ),
    );


  }
}
