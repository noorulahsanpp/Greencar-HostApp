
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
class CurrentLocation{

  CurrentLocation(){
    locatePosition();
}

  static Completer<GoogleMapController> _controllerGoogleMap = Completer();
  static GoogleMapController newGoogleMapController;

  static GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String currentloc;
  static String _address;
  static Position currentPosition;
  var geoLocator = Geolocator();

  static Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }
  static void locatePosition()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition, zoom:14);

    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    _getAddress(currentPosition.latitude, currentPosition.longitude).then((value) => {
      _address = value.first.addressLine
    });

  }
}