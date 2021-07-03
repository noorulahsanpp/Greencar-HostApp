import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/models/host_model.dart';
import 'package:driver_app/tabPages/homeTabPage.dart';
import 'package:driver_app/tabPages/profileTabPage.dart';
import 'package:driver_app/tabPages/requestsTabPage.dart';
import 'package:driver_app/tabPages/reviewsTabPage.dart';
import 'package:driver_app/util/configmaps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  TabController tabController;
  int selectedIndex = 0;


  void onItemClicked(int index){
    setState(() {
      selectedIndex = index;
      tabController.index = selectedIndex;
    });
  }


  getUserData() {
    User user = FirebaseAuth.instance.currentUser;
    driverReference.doc(user.uid).get().then((value) {
      setState(() {
        currentUser =HostModel.fromDocument(value);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
getUserData();
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeTabPage(),
          RequestTabPage(),
          ProfileTabPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.request_page), label: "Requests"),
          BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: "Profle"),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12),
        showSelectedLabels: true,
        onTap: onItemClicked,
        currentIndex: selectedIndex,
      ),
    );
  }



}
