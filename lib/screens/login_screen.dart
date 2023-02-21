import 'package:chat_test/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_test/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_test/screens/category_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'cards.dart';


class LoginScreen extends StatefulWidget {
  static const String id='Login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth =FirebaseAuth.instance;
  late String email;
   late String password;
  bool showSpinner=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(tag: 'logo',
                  child: Container(
                    height: 200.0,
                    padding: EdgeInsets.only(top: 10.0),
                    child: Image.asset('images/e-smartgym_logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email=value;
                  },
                  decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password=value;
                  },
                  decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: ()async {
                        setState(() {
                          showSpinner=true;
                        });
                        //Go to login screen.
                        try{
                          final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(user != null){
                            Navigator.pushNamed(context,cards.id);
                          }
                          setState(() {
                            showSpinner=false;
                          });
                        }catch(error){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text(error.toString()),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }

                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

