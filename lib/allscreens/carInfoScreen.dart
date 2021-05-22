import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/mainscreen.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/main.dart';
import 'package:driver_app/models/cars_model.dart';
import 'package:driver_app/models/host_model.dart';
import 'package:driver_app/util/configmaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/util/util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Car car;

class CarInfoScreen extends StatelessWidget {
  CarInfoScreen({Key key}) : super(key: key);

  static const String idScreen = "carinfo";
  TextEditingController carModelTextEditingController  = TextEditingController();
  TextEditingController carColorTextEditingController  = TextEditingController();
  TextEditingController carNumberTextEditingController  = TextEditingController();
  TextEditingController carSeatsTextEditingController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 22,
              ),
              Image.asset("images/greencar.png", width: 390,height: 250,),
              Padding(padding: EdgeInsets.fromLTRB(22, 22, 22, 32),
              child: Column(
                children: [
                  SizedBox(height: 12,),
                  Text("Enter Car Details", style: TextStyle(fontFamily: "Brand-Bold", fontSize: 24),),
                  SizedBox(height: 26,),
                  TextField(
                    controller: carModelTextEditingController,
                    decoration: InputDecoration(
                      labelText: "Car Model",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: carNumberTextEditingController,
                    decoration: InputDecoration(
                      labelText: "Car Number",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: carColorTextEditingController,
                    decoration: InputDecoration(
                      labelText: "Car Color",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: carSeatsTextEditingController,
                    decoration: InputDecoration(
                      labelText: "Seats Available",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: RaisedButton(
                    onPressed: (){

                      if(carModelTextEditingController.text.isEmpty){
                        Util.displayToastMessage("Model field cant be empty",context);
                      }
                      else if(carNumberTextEditingController.text.isEmpty){
                        Util.displayToastMessage("Model field cant be empty",context);
                      }
                      else if(carColorTextEditingController.text.isEmpty){
                        Util.displayToastMessage("Model field cant be empty",context);
                      }
                      else{
                        saveDriverCarInfo(context);
                      }

                    },
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Finish", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                          // Icon(Icons.arrow_forward, color: Colors.white, size: 26,),
                        ],
                      ),
                    ),
                  ),)
                ],
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveDriverCarInfo(context) async {
    String userId = currentFirebaseUser.uid;
    Map<String, String> carInfoMap = {
      "owner_userid":userId,
      "car_color":carColorTextEditingController.text,
      "car_model":carModelTextEditingController.text,
      "car_number":carNumberTextEditingController.text,
      "car_seats":carSeatsTextEditingController.text,
    };

    String carid="";
    String uis = currentUser.userid;
    driverReference.doc(userId).collection("car_details").add(carInfoMap).then((value) async {
      // print("saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${value.id}");
      carid = value.id;
      DocumentSnapshot documentSnapshot = await driverReference.doc(uis).collection("car_details").doc(carid).get();
      car = Car.fromDocument(documentSnapshot);
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    Util.displayToastMessage(
        "Your account has been created successfully", context);
    Navigator.pushNamedAndRemoveUntil(
        context, MainScreen.idScreen, (route) => false);
  }
}
