import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{

  int _selectedMenuOpt = 0;

  int get getSelectedMenuOpt {
    return this._selectedMenuOpt;
  }

    set setSelectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    notifyListeners();
  }



}