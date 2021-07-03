import 'package:driver_app/allscreens/loginscreen.dart';
import 'package:driver_app/allscreens/registrationscreen.dart';
import 'package:driver_app/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _oldPasswordTextEditingController =
      TextEditingController();
  TextEditingController _newPasswordTextEditingController =
      TextEditingController();
  TextEditingController _confirmNewPasswordTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _oldPasswordTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Old Password",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                ),
                TextField(
                  controller: _newPasswordTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "New Password",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                ),
                TextField(
                  controller: _confirmNewPasswordTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GestureDetector(child: Text("Forgot Password"),onTap: forgotPassword,)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  child: Text("Update Password"),
                  onPressed: () {
                    changePassword();
                  },
                ),
              ],
            ),
          ),
          SizedBox()
        ],
      )
    );
  }

  Future changePassword() {
    if (_newPasswordTextEditingController.text ==
        _confirmNewPasswordTextEditingController.text) {
      try {
        FirebaseAuth.instance.currentUser
            .reauthenticateWithCredential(EmailAuthProvider.credential(
                email: currentUser.email,
                password: _oldPasswordTextEditingController.text))
            .then((value) {
          FirebaseAuth.instance.currentUser
              .updatePassword(_newPasswordTextEditingController.text);
          Util.displayToastMessage("Password successfully updated", context);
          Navigator.pop(context);
        });
      } catch (error) {
        Util.displayToastMessage(error, context);
      }
    } else {
      Util.displayToastMessage("Password Does not match", context);
    }
  }

  Future forgotPassword() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: currentUser.email);
    Util.displayToastMessage(
        "Password reset link has been sent to your mail", context);
    FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
