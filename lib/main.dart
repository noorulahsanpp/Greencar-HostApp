import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/carInfoScreen.dart';
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
  runApp(MyApp());
}

// DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child("users");
CollectionReference<Map<String, dynamic>> driverReference = FirebaseFirestore.instance.collection("hosts");

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
        initialRoute: MainScreen.idScreen,
        routes: {
          RegistrationScreen.idScreen:(context) => RegistrationScreen(),
          LoginScreen.idScreen:(context) => LoginScreen(),
          MainScreen.idScreen:(context) => MainScreen(),
          CarInfoScreen.idScreen:(context) => CarInfoScreen(),
        },
        home: LoginScreen(),
      ),
    );
  }
}

