import 'package:flutter_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;

  final Function onClick;

  CustomTextField({@required this.onClick,@required this.hint, @required this.icon});

  String _errorMessage(String str){
    switch(str){
      case 'Enter your name' : return 'Name is empty';
      case 'Enter your E-mail' : return 'E-mail is empty';
      case 'Enter your password' : return 'Password is empty';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        // it's text field with ability to validate data
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(this.hint);
          }
          // ignore: missing_return
        },
        onSaved: this.onClick,
        obscureText: this.hint == 'Enter your password' ? true : false ,
        cursorColor: KMainColor,
        decoration: InputDecoration(
            hintText: this.hint,
            prefixIcon: Icon(icon, color: KMainColor),
            filled: true,
            // default: false, important to make text field accept the fill color instead of transparency color
            fillColor: KEmailTextFieldColor,
            enabledBorder: OutlineInputBorder(
                // Default : UnderlineInputBorder
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                // Default : UnderlineInputBorder
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                // Default : UnderlineInputBorder
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
