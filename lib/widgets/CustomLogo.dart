import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("resources/images/icons/buyIcon.png"),
              ),
              Positioned(
                  bottom: 0,
                  child: Text(
                    'Buy it',
                    style:
                    TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                  ))
            ],
          )
      ),
    );
  }
}
