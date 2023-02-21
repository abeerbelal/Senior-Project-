import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';


class ChooseExercise extends StatefulWidget {
  static const String id='Choose_exercise_screen';
  const ChooseExercise({Key? key}) : super(key: key);

  @override
  State<ChooseExercise> createState() => _ChooseExerciseState();
}

class _ChooseExerciseState extends State<ChooseExercise> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

