

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qutub_clinet/models/productModel.dart';

import 'CommonCollections.dart';

Future<void> addProductToFavourite(ProductModel productModel) async {
  
  //getUserID
  User user;
  user =  FirebaseAuth.instance.currentUser;
  String id = user.uid;



  //insert favourote
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(id)
      .collection(MyCollections.favourite)
      .doc(productModel.id)
      .set(productModel.toMap());
  return true;

}

Future<void>removeProductFavourite(ProductModel model) async {
 User user =  FirebaseAuth.instance.currentUser;
  String id = user.uid;
  
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(id)
      .collection(MyCollections.favourite)
      .doc(model.id).delete();

}

Future<dynamic> foundProductFavourite(String productID) async {
  bool founded=false;
 User user =  FirebaseAuth.instance.currentUser;
  String id = user.uid;
  
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(id)
      .collection(MyCollections.favourite)
      .get().then((value) => value.docs.forEach((element) { 

        if(productID==element.id){
          founded=true;
        }
      }));

      return founded;
}