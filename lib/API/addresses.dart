import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/models/addressModel.dart';

Future<dynamic> insertNewAddress(AddressModel model) async {
  //getUserID
  User user =  FirebaseAuth.instance.currentUser;
  String id = user.uid;

  //disable allAddresses
  await   FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(id)
      .collection(MyCollections.address)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      element.reference.update({'enabled': false});
    });
  });

  //insert newAddress
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(id)
      .collection(MyCollections.address)
      .doc()
      .set(model.toMap());
  return true;
}

Future<void> setDefaulsAddress(String addID) async {
  User user =  FirebaseAuth.instance.currentUser;
  String id = user.uid;
  //disable allAddresses
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(id)
      .collection(MyCollections.address)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      element.reference.update(
          {'enabled': (element.id == addID) ? true : false});
    });
  });
}


Future<void>removeAddress(String addID) async {
 User user =  FirebaseAuth.instance.currentUser;
  String id = user.uid;
  
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(id)
      .collection(MyCollections.address)
      .doc(addID).delete();

}