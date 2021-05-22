import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails{
  String id;
  String name;
  String email;
  String phone;
  String location;

  UserDetails({
      this.id,
      this.name,
      this.email,
      this.phone,
      this.location});

  factory UserDetails.fromDocument(DocumentSnapshot doc){
    return UserDetails(
        id:doc['userid'],
        name:doc['name'],
        email:doc['email'],
        phone:doc['phone'],
      location: doc['location'],
    );
  }
}