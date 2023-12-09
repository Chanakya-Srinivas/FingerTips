import 'package:flutter/widgets.dart';

class NewsNotifier with ChangeNotifier{

  void refreshSearchList(){
    notifyListeners();
  }

}