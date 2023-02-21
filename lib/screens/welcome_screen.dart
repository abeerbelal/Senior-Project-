import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
 late Animation animation;

  @override
  void initState() {
    super.initState();
    //parent :for which animation we want to applay curves
    // animation=CurvedAnimation(parent:controller, curve: Curves.easeIn);
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.white, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {

    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 100.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/e-smartgym_logo.png'),
                      height: 60.0,
                    ),
                  ),
                  TypewriterAnimatedTextKit(
                    text: ['e-smart-gym'],
                    textStyle: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.orangeAccent
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              elevation: 5.0,
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                  //Go to login screen.
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                      //Go to login screen.
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'register',
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
    );
  }
}


//this to make the animation skeep working when the state reaches the end "completed" revers and work
//repeat it self hole of running
// animation.addStatusListener((status) {
//   if(status==AnimationStatus.completed){
//     controller.reverse(from:1.0);
//   }else if(status==AnimationStatus.dismissed){
//     controller.forward();
//   }
// });