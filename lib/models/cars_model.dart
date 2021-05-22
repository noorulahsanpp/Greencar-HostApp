import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Car {
  String userid;
  String number;
  String color;
  String model;
  String seats;

  Car({
     this.userid,
     this.number,
     this.color,
     this.model,
    this.seats,
  });

  factory Car.fromDocument(DocumentSnapshot doc){
    return Car(
      userid:doc['owner_userid'],
      number:doc['car_number'],
      color:doc['car_color'],
      model:doc['car_model'],
      seats:doc['car_seats'],
    );
  }
}
