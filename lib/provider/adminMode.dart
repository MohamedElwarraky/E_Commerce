import 'package:flutter/widgets.dart';

class AdminMode extends ChangeNotifier{
  bool isAdmin = false;

  changeState(bool value){
    isAdmin = value;
    notifyListeners();
  }
}