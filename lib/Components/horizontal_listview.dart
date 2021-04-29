import 'package:flutter/material.dart';
//import 'package:carousel_pro/carousel_pro.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(image_Location: "images/gadgets/acer.png", image_Caption: 'Laptop'),
          Category(image_Location: "images/gadgets/Applephone2.png", image_Caption: "Phones",),
          Category(image_Location: "images/gadgets/camera2.jpg", image_Caption: "Camera",),
          Category(image_Location: "images/gadgets/computer-all-in-one-png-7.png", image_Caption: "Desktop Computers",),
          Category(image_Location: "images/gadgets/hpprinter.jpg", image_Caption: "Printers",),
          Category(image_Location: "images/gadgets/watch2.jpg", image_Caption: "Watches",)
        ],
      ),
    );
  }
}



class Category extends StatelessWidget {
  final String image_Location;
  final String image_Caption;

  Category({this.image_Location, this.image_Caption});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(2),
      child: InkWell(onTap: (){},child: Container(width:100,child: ListTile(title: Image.asset(image_Location, width: 100, height: 80,), subtitle: Container(alignment: Alignment.topCenter,child: Text(image_Caption),),)),),);
  }
}
