import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/loginscreen.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/models/host_model.dart';
import 'package:driver_app/util/configmaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String userId = currentFirebaseUser.uid;
final userRef = FirebaseFirestore.instance.collection("hosts").doc(userId);

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key key}) : super(key: key);

  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {

  String name = currentUser.name;
  String phone = currentUser.phone;
  String email = currentUser.email;
  @override
  void initState(){
    super.initState();
  }

  // getUserDetail(){
  //   userRef.get().then((QuerySnapshot snapshot) {
  //     // snapshot.d
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(name),
            Text(email),
            Text(phone),
            RaisedButton(
              child: Text("Logout"),
              onPressed: (){
FirebaseAuth.instance.signOut();
Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }


}




