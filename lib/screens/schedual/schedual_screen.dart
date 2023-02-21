import 'package:chat_test/screens/schedual/services/theme_services.dart';
import 'package:chat_test/screens/schedual/user_interfaces/home_page.dart';
import 'package:chat_test/screens/schedual/user_interfaces/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';



class schedule extends StatelessWidget {
  static const String id='Schedule_Screen';
  const schedule({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter crud Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeService().theme,// here we decide in which theme we are
      theme: Themes.light,
      darkTheme: Themes.dark,
      home: const HomePage(),
    );
  }
}
