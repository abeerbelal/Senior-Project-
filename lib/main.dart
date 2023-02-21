import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:chat_test/screens/welcome_screen.dart';
import 'package:chat_test/screens/login_screen.dart';
import 'package:chat_test/screens/registration_screen.dart';
import 'package:chat_test/screens/chat_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'screens/category_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/cards.dart';
import 'screens/learnExercise/choose_exersice.dart';
import 'screens/bmi/bmi_screen.dart';
import 'package:chat_test/screens/schedual/DB/db_helper.dart';
import 'package:chat_test/screens/schedual/schedual_screen.dart';
import 'screens/profil.dart';
import 'screens/nutrition/screens_nutrition/home.dart';
import 'screens/ch.dart';



Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   await DBHelper.initDb();
   await GetStorage.init();
  runApp(Gym());//we must change this name to gym
}
class Gym extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        CategoryScreen.id:(context)=>CategoryScreen(),
        cards.id:(context)=>cards(),
        ChooseExercise.id:(context)=>ChooseExercise(),
        BMICalculator.id: (context)=>BMICalculator(),
        schedule.id: (context) => schedule(),
        Profile.id:(context)=>Profile(),
        nutrition_page.id:(context)=>nutrition_page(),
        Chart.id:(context)=>Chart(),




      },
    );
  }
}
