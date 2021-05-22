import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/allscreens/mainscreen.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/allwidgets/progressdialog.dart';
import 'package:driver_app/util/firebaseutil.dart';
import 'package:driver_app/util/util.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  DatabaseReference usersRef = FirebaseUtil.createDatabaseReference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Image(
              image: AssetImage("images/greencar.png"),
              width: 390,
              height: 250,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              "Login as Host",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Brand Bold",
                  color: Color(0xff717d8c)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: _passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (!_emailTextEditingController.text.contains('@') ||
                          _emailTextEditingController.text.isEmpty) {
                        Util.displayToastMessage(
                            "Email Address is not valid", context);
                      } else if (_passwordTextEditingController.text.length <
                          7) {
                        Util.displayToastMessage(
                            "Password must be at least 6 characters", context);
                      } else {
                        loginAndAuthenticateUser(context);
                      }
                    },
                    color: Color(0xff3dcd84),
                    textColor: Colors.white,
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Login",
                          style:
                              TextStyle(fontSize: 18, fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24)),
                  )
                ],
              ),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Text("Do not have an account? Register here."))
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return ProgressDialog(message: "Authenticating, Please wait...",);
      }
    );

    final User user = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: _emailTextEditingController.text,
                password: _passwordTextEditingController.text)
            .catchError((errMsg) {
              Navigator.pop(context);
      Util.displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;
    if (user != null) {
      usersRef.child(user.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {

          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          Util.displayToastMessage("You're logged in", context);
        } else {
          _firebaseAuth.signOut();
          Navigator.pop(context);
          Util.displayToastMessage(
              "No Record exits for this user. Please create new account",
              context);
        }
      });
    } else {
      Navigator.pop(context);
      Util.displayToastMessage("Error occured. Failed to sign in.", context);
    }
  }
}
