import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qutub_clinet/models/aboutUsModel.dart';
import 'CommonCollections.dart';

Future<void> insertNewAboutUs({String aboutTxt}) async {
  await FirebaseFirestore.instance
      .collection(MyCollections.aboutUs)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      element.reference.delete();
    });
  });

  return await FirebaseFirestore.instance
      .collection(MyCollections.aboutUs)
      .doc()
      .set(AboutUsModel(txt: aboutTxt).toMap());
}
