import 'package:flutter/material.dart';
import 'constant.dart';

class iconContent extends StatelessWidget {
  iconContent({required this.icon,required this.lable});
  final IconData icon;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(lable,style:kLableTextStyle ,
        )
      ],
    );
  }
}