import 'package:flutter/material.dart';
import 'package:hero/models/travel.dart';

class TravelsProvider extends ChangeNotifier {
  String? view;
  Travel? travel;

  TravelsProvider(
    {this.view = 'bacheca', this.travel}
  );

  void changeView(String newView) {
    view = newView;
    notifyListeners();
  }

  void selectTravel(Travel obj) {
    travel = obj;
    notifyListeners();
  }

  void clearDetail() {
    travel = null;
    notifyListeners();
  }

}
