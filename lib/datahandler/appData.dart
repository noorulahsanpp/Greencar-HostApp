import 'package:flutter/material.dart';
import 'package:driver_app/models/address.dart';

class AppData extends ChangeNotifier{
Address pickUpLocation;
void updatePickUpLocationAddress(Address pickupaddress){
  pickUpLocation = pickupaddress;
  notifyListeners();
}
}