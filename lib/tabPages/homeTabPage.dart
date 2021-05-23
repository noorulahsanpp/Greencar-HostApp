
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/addTrip.dart';
import 'package:driver_app/allscreens/mainscreen.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/allwidgets/progressdialog.dart';
import 'package:driver_app/main.dart';
import 'package:driver_app/models/host_model.dart';
import 'package:driver_app/models/trip_model.dart';
import 'package:driver_app/util/configmaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final userRef = FirebaseFirestore.instance.collection("hosts").doc(userId);
List<TripModel> tripModelList;

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  // final List<>

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
            stream: driverReference
                .doc(currentUser.userid)
                .collection("trips").orderBy("date")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Error");
              }
              final list = snapshot.data.docs;
              if (list.length<=0) {
                return Center(child: new Text("No Trips"));
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
                              colors: [Colors.white, Colors.blueGrey.shade50])
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      width: MediaQuery.of(context).size.width,
                      height: 160,
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
                                      color: Colors.black
                                  ),),
                                ),
                                Expanded(child: Icon(FontAwesomeIcons.solidCaretSquareRight)),
                                Expanded(
                                  child: Text("${list[index]["to_place"].toUpperCase()}",style: TextStyle(
                                      fontSize: 20,
                                    color: Colors.black
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
                                    color: Colors.black
                                ),),
                                Text("Co-Passengers : 0",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                ),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Per Head : ${list[index]["shareprice"]}",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                ),),
                                Text("Date : ${list[index]["date"]}",style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black
                                ),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: RaisedButton(onPressed: (){

                                  },
                                  child: Text("START"),),
                                ),
                                RaisedButton(onPressed: (){
cancelTrip(context, list[index].id);
                                },
                                  child: Text("CANCEL"),
                                ),
                              ],
                            )
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTrip()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Future<void> cancelTrip(BuildContext context,String tripid) async {
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
        .doc(tripid).delete().then((value) {
          FirebaseFirestore.instance.collection('hosts').doc(currentUser.userid).collection('trips').doc(tripid).delete();
          Navigator.pushNamed(context, MainScreen.idScreen);
    });
  }
}

// class Sam extends StatelessWidget {
//   const Sam({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return new StreamBuilder<QuerySnapshot>(
//       stream: driverReference.doc(currentUser.userid).collection("trips").snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>
//             snapshot){
//           if (!snapshot.hasData) return new Text("There is no Trip");
//         });
//   }
// }

// InkWell(
// child: ListView.separated(
// scrollDirection: Axis.vertical,
// separatorBuilder: (context, index) => SizedBox(height: 8,),
// itemCount: 10,
// itemBuilder: (context, index) => ClipRRect(
// borderRadius: BorderRadius.all(Radius.circular(20)),
// child: InkWell(
// child: Container(
// width: MediaQuery.of(context).size.width,
// height: 160,
// color: Colors.lightGreen,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text("Hi")
// ],
// ),
// ),
//
// onTap: () => {
// // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMoviePoster(imageUrl: posters[index],)))
// },
// ),
// ),
//
// ),
//
// ),
