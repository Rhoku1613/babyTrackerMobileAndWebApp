import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme()=>_themeData;

  setTheme(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }
}