import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';

class CartCounterProvider extends ChangeNotifier {
  int count = 0;

  CartCounterProvider() {
    getCount();
  }

  getCount() async {
    User user =  FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('''object''');
      await FirebaseFirestore.instance
          .collection(MyCollections.userCollection)
          .doc(user.uid)
          .collection(MyCollections.cart)
          .get()
          .then((value) {
        count = value.docs.length;
        print('Value:${value.docs.length}');
        print(count);
         notifyListeners();
      });
     
    }
  }

  setCount(){
    count++;
    notifyListeners();
  }

  decrementCount(){
    count--;
    notifyListeners();
  }

  clearCartCounter(){
    count=0;
    notifyListeners();
  }
}
