import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/mainscreen.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/allwidgets/progressdialog.dart';
import 'package:driver_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewRequest extends StatefulWidget {
  final String tripId;

  const ViewRequest({Key key, this.tripId}) : super(key: key);

  @override
  _ViewRequestState createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("hosts")
              .doc(currentUser.userid)
              .collection("trips").doc(widget.tripId).collection('requests')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasError) {
              return Text("Error");
            }
            final list = snapshot.data.docs;
            if (list.length<=0) {
              return Center(child: new Text("No Request"));
            }else {
              return ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => SizedBox(
                  height: 8,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.blueGrey.shade50])),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      // color: Color.fromRGBO(64, 75, 96, .9),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${list[index]["ridername"].toUpperCase()}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${list[index]["riderphone"].toUpperCase()}",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      acceptRequest(
                                          context, list[index]["riderid"],list[index]["tripid"], );
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.close,
                                    ),
                                    onPressed: () {
                                      rejectRequest(
                                          context, list[index]["riderid"],list[index]["tripid"],);
                                    })
                              ],
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rating : ${list[index]["riderrating"]}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () => {
// Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMoviePoster(imageUrl: posters[index],)))
                    },
                  ),
                ),
              );
            }
          }),
    );
  }

  Future<void> acceptRequest(BuildContext context, String riderid, String tripid) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Setting Up, Please wait...",
          );
        });

    Map<String, dynamic> tripDataMap = {
      "riderid": currentUser.userid,
      "tripid": tripid,
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.userid)
        .collection('trips')
        .add(tripDataMap)
        .then((value) {
      FirebaseFirestore.instance
          .collection('trips')
          .doc(tripid)
          .collection("request").where("riderid", isEqualTo: riderid)
          .get().then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance.collection("trips").doc(tripid).collection("request")
              .doc(element.id)
              .delete();
        });
      });
      Navigator.pushNamed(context, MainScreen.idScreen);
    }).catchError((error) => print("Failed to add request: $error"));
  }

  Future<void> rejectRequest(BuildContext context, String riderid, String tripid) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Setting Up, Please wait...",
          );
        });

    FirebaseFirestore.instance
        .collection('trips')
        .doc(tripid)
        .collection("request").where("riderid", isEqualTo: riderid)
        .get().then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance.collection("trips").doc(tripid).collection(
            "request")
            .doc(element.id)
            .delete()
            .then((value) {
          Navigator.pushNamed(context, MainScreen.idScreen);
        }).catchError((error) => print("Failed to add request: $error"));
      });
    });
}
}
