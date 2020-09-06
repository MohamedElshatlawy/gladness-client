import 'package:flutter/foundation.dart';

class BottomNavProvider extends ChangeNotifier {
  int selectedIndex = 2;

  onTapClick(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  String getTabName() {
    switch (selectedIndex) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'الحجوزات';
      // case 2:
      //   return 'المشتريات';
      case 2:
        return 'التصنيفات';
    }
    return '';
  }
}