import 'dart:convert';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:driver_app/datahandler/appData.dart';
import 'package:driver_app/models/address.dart' as addr;
class RequestAssistant {

  static Future<dynamic> getRequest(String url)async{
    http.Response response = await http.get(Uri.parse(url));

try{
  if(response.statusCode == 200){
    String jsonData = response.body;
    var decodeData = jsonDecode(jsonData);
    return decodeData;
  }
  else{
    return "Failed, No Response";
  }
}
catch(exp){
  return "Failed";
}

  }

  static Future<String> getAddress(double lat, double lang, context) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);

    addr.Address locaddress = new addr.Address();
    locaddress.latitude = lat.toString();
    locaddress.longitude = lang.toString();
    locaddress.placeName = add.first.thoroughfare;
    // locaddress.placeFormattedAddress = add.first.addressLine;

    print("coordinated;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${add.first.coordinates}");
    print("coordinated;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${add.first.featureName}");
    print("coordinated;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${lat},${lang}");
    print("coordinated;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${add.first.locality}");
    print("coordinated;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${add.first.subAdminArea}");
    print("coordinated;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${add.first.adminArea}");
    print("coordinated;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${add.first.thoroughfare}");
    print("coordinated;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;${add.first.addressLine}");
    
    
    Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(locaddress);

    return add.first.addressLine;


  }

}