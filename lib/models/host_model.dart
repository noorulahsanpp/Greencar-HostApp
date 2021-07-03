import 'package:cloud_firestore/cloud_firestore.dart';

class HostModel {
  final String userid;
  final String name;
  final String email;
  final String phone;
  final int rating;
  final int noofrating;

  HostModel({
    this.userid,
    this.name,
    this.email,
    this.phone,
    this.rating,
    this.noofrating,
  });

  factory HostModel.fromDocument(DocumentSnapshot doc){
    return HostModel(
      userid:doc['userid'],
      name:doc['name'],
      email:doc['email'],
      phone:doc['phone'],
      rating: doc['rating'],
        noofrating:doc['noofrating'],
    );
  }
}