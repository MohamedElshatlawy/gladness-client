import 'package:flutter/foundation.dart';

import '../Locale/appLocalization.dart';

class BottomNavProvider extends ChangeNotifier {
  int selectedIndex = 0;

  onTapClick(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  String getTabName(AppLocalizations local) {
    switch (selectedIndex) {
      case 3:
        return local.translate('more_tab');
      case 2:
        return local.translate('resv_tab');
      // case 2:
      //   return 'المشتريات';
      case 1:
        return local.translate('cat_tab');
      case 0:
        return local.translate('home_tab');
    }
    return '';
  }
}
