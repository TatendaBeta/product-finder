import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseManager {
  final CollectionReference products =
  FirebaseFirestore.instance.collection('products');

  Future<void> createUserData(
      String productName, int productPrice, String productDetail, String Link) async {
    return await products
        .doc()
        .set({'productName': productName, 'productPrice': productPrice, 'productDetail': productDetail, 'Link': Link});
  }


  Future getUsersList() async {
    List product_List = [];

    try {
      await products.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          product_List.add(element);
        });
      });
      return product_List;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
