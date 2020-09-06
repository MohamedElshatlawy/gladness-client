import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/models/addressModel.dart';

class AddressProvider extends ChangeNotifier{
  AddressModel addressModel;

  void setSelectedAddress(AddressModel add){
    addressModel=add;
    notifyListeners();
  }

  
}