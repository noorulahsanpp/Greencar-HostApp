import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/mainscreen.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/allwidgets/progressdialog.dart';
import 'package:driver_app/main.dart';
import 'package:driver_app/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({Key key}) : super(key: key);

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  TextEditingController _fromPlaceTextEditingController =
      TextEditingController();
  TextEditingController _toPlaceTextEditingController = TextEditingController();
  TextEditingController _dateTextEditingController = TextEditingController();
  TextEditingController _seatsTextEditingController = TextEditingController();
  TextEditingController _sharepriceTextEditingController = TextEditingController();

  TextEditingController _timeTextEditingController = TextEditingController();

  DateTime currentDate = DateTime.now();

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  Future<void> _selectDate(BuildContext context) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        _dateTextEditingController.text = formatter.format(currentDate);
      });
  }

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        print(_time);
        _timeTextEditingController = TextEditingController(text: _time.format(context));
        print(_timeTextEditingController.text);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image(
              image: AssetImage("images/greencar.png"),
              width: 390,
              height: 200,
              alignment: Alignment.center,
            ),

            Text(
              "Register Trip",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Brand Bold",
                  color: Color(0xff717d8c)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _fromPlaceTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "From",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _toPlaceTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "To",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 1,
                  ),

                  TextField(
                    controller: _dateTextEditingController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.date_range,
                          ),
                          onPressed: () => _selectDate(context),
                        ),
                        labelText: "Date",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 1,
                  ),

                  TextField(
                    controller: _timeTextEditingController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.more_time,
                          ),
                          onPressed: () => _selectTime(),
                        ),
                        labelText: "Time",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _seatsTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Seats",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _sharepriceTextEditingController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      prefix: Icon(FontAwesomeIcons.rupeeSign),
                        labelText: "Share Per Head",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_toPlaceTextEditingController.text.isEmpty) {
                        Util.displayToastMessage(
                            "To Address cannot be empty", context);
                      } else if (_fromPlaceTextEditingController.text.isEmpty) {
                        Util.displayToastMessage(
                            "From Address is not valid", context);
                      } else if (_dateTextEditingController.text.isEmpty) {
                        Util.displayToastMessage(
                            "Date cannot be empty", context);
                      } else if (_seatsTextEditingController.text.isEmpty) {
                        Util.displayToastMessage(
                            "Seat cannot be empty", context);
                      } else {
                        registerNewTrip(context);
                      }
                    },
                    color: Color(0xff3dcd84),
                    textColor: Colors.white,
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pack up",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.flight_takeoff,
                            color: Colors.white,
                            size: 26,
                          ),
                        ],
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> registerNewTrip(BuildContext context) async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "Setting Up, Please wait...",);
        }
    );

    List<Location> fromplacelatlong = await findPlace(_fromPlaceTextEditingController.text.trim());
    List<Location> toplacelatlong = await findPlace(_toPlaceTextEditingController.text.trim());

    double fromplacelat= fromplacelatlong.first.latitude;
    double fromplacelong= fromplacelatlong.first.longitude;
    double tolacelat= toplacelatlong.first.latitude;
    double toplacelong= toplacelatlong.first.longitude;


    List fromplacelatlong1 = new List();
    fromplacelatlong1.add(fromplacelat);
    fromplacelatlong1.add(fromplacelong);
    List toplacelatlong1 = new List();
    toplacelatlong1.add(tolacelat);
    toplacelatlong1.add(toplacelong);



      Map<String, dynamic> tripDataMap = {
        "to_place": _toPlaceTextEditingController.text.trim().toUpperCase(),
        "from_place": _fromPlaceTextEditingController.text.trim().toUpperCase(),
        "date": _dateTextEditingController.text.trim(),
        "time": _timeTextEditingController.text.trim(),
        "seats": _seatsTextEditingController.text.trim(),
        "shareprice":_sharepriceTextEditingController.text.trim(),
        "host": currentUser.userid,
        "fromplacelatlong" : fromplacelatlong1,
        "toplacelatlong" : toplacelatlong1,
        "status": "idle",
      };

    driverReference.doc(currentUser.userid).collection("trips").add(tripDataMap).then((value) {
      Map<String, dynamic> aa ={
        "tripid":value.id,
      };
      driverReference.doc(currentUser.userid).collection("trips").doc(value.id).update(aa);
      tripDataMap.addAll(aa);
      FirebaseFirestore.instance.collection("trips").doc(value.id).set(tripDataMap);
      Util.displayToastMessage(
          "Your Trip has been created successfully", context);
      Navigator.pushNamed(
          context, MainScreen.idScreen);
    }).catchError((error) => print("Failed to add trip: $error"));

    }
  Future<List<Location>> findPlace(String placeName) async{
    List<Location> locations;
      locations = await locationFromAddress(placeName);
    return locations;
  }
}
