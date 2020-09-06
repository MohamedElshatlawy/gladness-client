import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/common.dart';
import 'package:qutub_clinet/models/productModel.dart';

Future<dynamic> getProductDetails(String productID) async {
  ProductModel productModel;
  await FirebaseFirestore.instance
      .collection(MyCollections.products)
      .doc(productID)
      .get()
      .then((value) {
    productModel =
        ProductModel.fromJson(id: value.id, json: value.data());
  });

  return productModel;
}

Future<dynamic> confirmOrder(String orderID) async {
  await FirebaseFirestore.instance
      .collection(MyCollections.orders)
      .doc(orderID)
      .update({'orderStatus': Common.confirmedStatus});
}
