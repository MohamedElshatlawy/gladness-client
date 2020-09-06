import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qutub_clinet/models/couponModel.dart';

import 'CommonCollections.dart';

Future<void> insertNewCoupon({CouponModel couponModel}) async {
  
  return await FirebaseFirestore.instance
      .collection(MyCollections.coupon)
      .doc()
      .set(couponModel.toMap());
}

Future<void> removeCoupon(CouponModel couponModel) async {
  return await FirebaseFirestore.instance
      .collection(MyCollections.coupon)
      .doc(couponModel.id)
      .delete();
}