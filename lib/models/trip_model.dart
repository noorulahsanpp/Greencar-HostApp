import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel{
  String fromplace;
  String toplace;
  String date;
  String seats;
  List fromplacelatlong;
  List toplacelatlong;

  TripModel({this.fromplace, this.toplace, this.date, this.seats,
      this.fromplacelatlong, this.toplacelatlong});

  factory TripModel.fromDocument(DocumentSnapshot doc){
    return TripModel(
      fromplace:doc['from_place'],
      toplace:doc['to_place'],
      date:doc['date'],
      seats:doc['seats'],
      fromplacelatlong:doc['fromplacelatlong'],
      toplacelatlong:doc['toplacelatlong'],
    );
  }
}