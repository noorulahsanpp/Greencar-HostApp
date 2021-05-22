import 'package:firebase_database/firebase_database.dart';

class FirebaseUtil{

  static DatabaseReference createDatabaseReference(){
    DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child("users");
    return _databaseReference;
  }


}