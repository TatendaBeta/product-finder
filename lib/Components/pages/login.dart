import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productfinder/Components/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    //User firebaseUser = await firebaseAuth.signInWithCredential(idToken: googleSignInAuthentication.idToken, accessToken:googleSignInAuthentication.accessToken);
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    //User firebaseUser = credential as User;
    final UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);
    final User firebaseUser = authResult.user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> document = result.docs;
      if (document.length == 0) {
        // insert the user to our collection
        FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser.uid)
            .set({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "profilePicture": firebaseUser.photoURL
        });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.displayName);
      } else {
        await preferences.setString("id", document[0]['id']);
        await preferences.setString("username", document[0]['username']);
        await preferences.setString("photoUrl", document[0]["photoUrl"]);
      }
      Fluttertoast.showToast(msg: "Log in was successfull");

      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(msg: "Log in was failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("images/back2.jpg", fit: BoxFit.cover, width: double.infinity,height: double.infinity,),
          //----------TODO put LOGO-----------------
          //Container(alignment: Alignment.topCenter, child: Image.asset(""),),

          //it helps to reduce opacity of a background image
          Container(
            color: Colors.black.withOpacity(0.2),
            width: double.infinity,
            height: double.infinity,
          ),

          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top:200.0),
              child: Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // ------------------------------------This is for email-----------------------------------------------------------
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.8),
                            child: Padding(
                              padding: const EdgeInsets.only(left:18.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "Email",
                                  icon: Icon(Icons.email),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Please make sure your email address is valid';
                                  } return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        // ---------------------------this is for password----------------------------------
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.8),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hintText: "Password",
                                  icon: Icon(Icons.lock_outline),
                                ),
                               validator: (value){
                                  if(value.isEmpty){
                                    return "the password field cannot be empty";
                                  }else if(value.length<6){
                                    return "the pass has to contain at least 6 characters";
                                  } return null;
                               },
                              ),
                            ),
                          ),
                        ),

                        //------------------------------------ buttons --------------------------------------

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.indigo.withOpacity(0.8),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: (){},
                              child: Text("Login", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),

                        Divider(color: Colors.white,),
                        Text("Other SignIn Options ", style: TextStyle(color: Colors.white, fontSize: 20),),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red.withOpacity(0.8),
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: (){
                                handleSignIn();
                              },
                              child: Text("Google", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),

          Visibility(
              visible: loading ?? true,
              child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.7),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red,
                  ))))
        ],
      ),

    );
  }
}
