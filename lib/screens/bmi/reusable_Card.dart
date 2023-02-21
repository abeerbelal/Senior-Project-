import 'package:flutter/material.dart';
class ReuableCard extends StatelessWidget {
  // const ReuableCard({Key? key,}) : super(key: key);

  ReuableCard( {required this.colur, this.cardChild,this.onPress });

/*this proparity is immutable ,it means that when we create a new reusable
  card,we can set the color and we can  not change it again*/

  final Color colur;
  // " ? " this to notate that it could be null
  // it is a sol fo this error ==>error: The parameter 'cardChild' can't have a value of 'null' because of its type, but the implicit default value is 'null'.
  final Widget? cardChild;
  //sol of this error error: The argument type 'Function?' can't be assigned to the parameter type 'void Function()?'.
  final  void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: colur,
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
    );
  }
}