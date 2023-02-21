import 'package:chat_test/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'schedual/schedual_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_screen.dart';
import 'package:chat_test/screens/ch.dart';




class Profile extends StatelessWidget{
  static const String id='Profile_screen';
  String? displayName;
  @override
  Widget build (BuildContext context){
    //
    // if (FirebaseAuth.instance.currentUser != null) {
    // displayName = FirebaseAuth.instance.currentUser?.displayName;
    // } else {
    //   String displayName = "";
    // }
    String _auth = FirebaseAuth.instance.currentUser?.displayName ?? "";
    print(FirebaseAuth.instance.currentUser?.displayName);
    final _authN =FirebaseAuth.instance;
    return MaterialApp(

      home: Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: SafeArea(

          child: Container(
            margin: EdgeInsets.only(left: 80.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                CircleAvatar(
                  radius:70.0,
                  backgroundImage:AssetImage('images/yoga1a.jpg'),
                ),
                Text(
                  'welcome!',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PassionsConflict',
                  ),
                ),
                Text(' this is your profil',
                  style: TextStyle(
                      letterSpacing: 2.5,
                      fontSize: 20.0,color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceSansPro'

                  ),),
                SizedBox(
                  //the line between text and card
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                )
                ,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                         Navigator.pushNamed(context, Chart.id);
                        //Go to login screen.
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'History',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, schedule.id);
                        //Go to login screen.
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Schedual',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          await _authN.signOut();
                          print("Logged out successfully.");
                        } catch (e) {
                          print("Error logging out: $e");
                        }
                        Navigator.pushNamed(context, WelcomeScreen.id);
                        //Go to login screen.
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log Out',
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),),
      ),
    );
  }
}



