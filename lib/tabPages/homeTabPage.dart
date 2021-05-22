
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/addTrip.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/main.dart';
import 'package:driver_app/models/host_model.dart';
import 'package:driver_app/models/trip_model.dart';
import 'package:driver_app/util/configmaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String userId = currentFirebaseUser.uid;
final userRef = FirebaseFirestore.instance.collection("hosts").doc(userId);
List<TripModel> tripModelList;
Stream _stream;
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

  void getStreamc()async{
    _stream = await driverReference
        .doc(currentUser.userid)
        .collection("trips")
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: driverReference
              .doc(currentUser.userid)
              .collection("trips")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            final list = snapshot.data.docs;
            if (!snapshot.hasData)
              return new Text("No Trips");
            else {
              return ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => SizedBox(
                  height: 8,
                ),
                itemCount: list.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      color: Colors.lightGreen,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("${list[index]["date"]}")],
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
