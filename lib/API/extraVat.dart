import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qutub_clinet/models/extralVatModel.dart';

import 'CommonCollections.dart';

Future<void> insertNewExtraVat({String aboutTxt}) async {
  await FirebaseFirestore.instance
      .collection(MyCollections.extraVat)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      element.reference.delete();
    });
  });

  return await FirebaseFirestore.instance
      .collection(MyCollections.extraVat)
      .doc()
      .set(ExtraVatModel(txt: aboutTxt).toMap());
}