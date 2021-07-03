import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/allscreens/viewRequest.dart';
import 'package:driver_app/main.dart';
import 'package:driver_app/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RequestTabPage extends StatelessWidget {
  const RequestTabPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("hosts").doc(currentUser.userid).collection('trips')
              // .doc(currentUser.userid)
              // .collection("trips").orderBy("date")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            final list = snapshot.data.docs;
            if (list.length<=0) {
              return Scaffold(body: Center(child: new Text("No Request")),);
            }
            else {
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
                              colors: [Style.blacklight, Style.blacklight])
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      // color: Color.fromRGBO(64, 75, 96, .9),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text("${list[index]["from_place"].toUpperCase()}",style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white54
                                  ),),
                                ),
                                Expanded(child: Icon(FontAwesomeIcons.solidCaretSquareRight)),
                                Expanded(
                                  child: Text("${list[index]["to_place"].toUpperCase()}",style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white54
                                  ),),
                                ),
                              ],
                            ),
                            SizedBox(height: 1,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Seats : ${list[index]["seats"]}",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white54
                                ),),
                                Text("Co-Passengers : 0",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white54
                                ),),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    onTap: () => {
Navigator.push(context, MaterialPageRoute(builder: (context) => ViewRequest(tripId:list[index]["tripid"],fromplace: list[index]["from_place"],toplace: list[index]["to_place"],date: list[index]["date"],)))
                    },

                  ),
                ),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}