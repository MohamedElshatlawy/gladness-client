import 'package:flutter/foundation.dart';

class CountryCodeProvider extends ChangeNotifier{
  String countryCode='+20';

  void setCountry(String v){
    countryCode=v;
    notifyListeners();
  }
}