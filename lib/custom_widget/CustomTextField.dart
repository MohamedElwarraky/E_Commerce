import 'package:flutter_app/screens/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;

  CustomTextField({@required this.hint, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 30),
      child: TextField(
        cursorColor: KMainColor,
        decoration: InputDecoration(
            hintText: this.hint,
            prefixIcon: Icon(
                icon ,
                color : KMainColor
            ),
            filled: true, // default: false, important to make text field accept the fill color instead of transparency color
            fillColor: KEmailTextFieldColor,
            enabledBorder: OutlineInputBorder(
              // Default : UnderlineInputBorder
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
              // Default : UnderlineInputBorder
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
