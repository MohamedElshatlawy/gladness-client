

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qutub_clinet/models/contactUsModel.dart';

import 'CommonCollections.dart';

Future<void> insertNewContactPhone({String phone}) async {
  
  return await FirebaseFirestore.instance
      .collection(MyCollections.contactUs)
      .doc()
      .set(ContactPhoneNumberModel(
        phone: phone
      ).toMap());
}

Future<void> removeContactPhone(ContactPhoneNumberModel phoneModel) async {
  return await FirebaseFirestore.instance
      .collection(MyCollections.contactUs)
      .doc(phoneModel.id)
      .delete();
}