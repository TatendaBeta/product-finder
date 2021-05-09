import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productfinder/Components/pages/home.dart';
import 'package:productfinder/Components/pages/login.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:HomePage(), //Login()
  ));
}

