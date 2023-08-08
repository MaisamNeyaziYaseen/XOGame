import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ChangeNotifierProvider<GameController> gameProvider =
    ChangeNotifierProvider<GameController>((ref) => GameController());

class GameController extends ChangeNotifier {
  String _userSymbol = "X";
  bool _isXSelected = false;
  bool _isOSelected = false;

  setUserSymbol(String v) {
    _userSymbol = v;
    notifyListeners();
  }

  setisXSelected(bool v) {
    _isXSelected = v;
    notifyListeners();
  }

  setisOSelected(bool v) {
    _isOSelected = v;
    notifyListeners();
  }

  String get getUserSymbol => _userSymbol;
  bool get getisXSelected => _isXSelected;
  bool get getisOSelected => _isOSelected;
}
