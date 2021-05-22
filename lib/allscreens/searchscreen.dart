import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:driver_app/allwidgets/progressdialog.dart';
import 'package:driver_app/assistants/requestAssistant.dart';
import 'package:driver_app/datahandler/appData.dart';
import 'package:driver_app/pages/time_line_page.dart';
import 'package:driver_app/util/configmaps.dart';
import 'package:geocoding/geocoding.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    pickUpTextEditingController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  spreadRadius: .5,
                  offset: Offset(.7, .7))
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 25, top: 60, right: 25, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Center(
                        child: Text(
                          "Set Drop Off",
                          style:
                              TextStyle(fontSize: 18, fontFamily: "Brand-Bold"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/pickicon.png",
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: TextField(
                            controller: pickUpTextEditingController,
                            decoration: InputDecoration(
                                hintText: "Pickup Location",
                                fillColor: Colors.grey,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11, top: 8, bottom: 8)),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/desticon.png",
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: TextField(
                            onSubmitted: (val){
                              findPlace(val);
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> TimeLine()));
                            },
                            // onChanged: (val){
                            //   findPlace(val);
                            // },
                            controller: dropOffTextEditingController,
                            decoration: InputDecoration(
                                hintText: "Where to ?",
                                fillColor: Colors.grey,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11, top: 8, bottom: 8)),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: RaisedButton(
                          child: Text("Search", style: TextStyle(
                            color: Colors.white
                          ),),
                          onPressed: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> TimeLine()));
                          },
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  void findPlace(String placeName) async{

    if(placeName.length>1){
      // showDialog(context: context, builder: (BuildContext context) => ProgressDialog(message: "Setting Dropoff, Please Wait...",));
//       String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName}&key=$mapKey&sessiontoken=1234567890";
//       var res = await RequestAssistant.getRequest(autoCompleteUrl);
// print("ddddddddddddddddddddddddddddddddddddddddddddddddddd");
//       if(res == "Failed"){
//         return;
//       }
//       print("ssssssssssssssssssssssssssssssssssssssssssssss$res");
      List<Location> locations = await locationFromAddress(placeName);
      // Navigator.pop(context);
print("ssssssssssssssssssssssssssssssssssssss$locations");
    }
  }

}
