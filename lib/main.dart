import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/carInfoScreen.dart';
import 'package:driver_app/allscreens/startMap.dart';
import 'package:driver_app/models/host_model.dart';
import 'package:driver_app/util/configmaps.dart';
import 'package:driver_app/util/firebaseutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:driver_app/allscreens/loginscreen.dart';
import 'package:driver_app/allscreens/mainscreen.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/datahandler/appData.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
currentFirebaseUser = FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}

// DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child("users");
CollectionReference<Map<String, dynamic>> driverReference = FirebaseFirestore.instance.collection("hosts");
String userId = currentFirebaseUser.uid;
DatabaseReference tripRequestRef = FirebaseDatabase.instance.reference().child("drivers").child(currentUser.userid).child("newRide");


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Brand Bold",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen : MainScreen.idScreen,
        routes: {
          RegistrationScreen.idScreen:(context) => RegistrationScreen(),
          LoginScreen.idScreen:(context) => LoginScreen(),
          MainScreen.idScreen:(context) => MainScreen(),
          CarInfoScreen.idScreen:(context) => CarInfoScreen(),
          MapView.idScreen:(context) => MapView(),
        },
        home: LoginScreen(),
      ),
    );
  }
}

