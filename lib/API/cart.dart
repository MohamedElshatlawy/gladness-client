import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/Providers/cartItemsCounterProvider.dart';
import 'package:qutub_clinet/models/addressModel.dart';
import 'package:qutub_clinet/models/couponModel.dart';
import 'package:qutub_clinet/models/extralVatModel.dart';
import 'package:qutub_clinet/models/orderModel.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';

Future<dynamic> addProductToCart(
    ProductModel productModel, int quantity, var ctx) async {
  User user =  FirebaseAuth.instance.currentUser;

  //CheckIf product is exists
  bool founded = false;
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(user.uid)
      .collection(MyCollections.cart)
      .get()
      .then((value) => value.docs.forEach((doc) {
            if (doc.id == productModel.id) {
              founded = true;

              int quantity1 = doc.data()['quantity'];
              quantity1 += quantity;
              doc.reference.update({'quantity': quantity1});
            }
          }));

//InsertNewProduct

  if (founded == false) {
    Map<String, dynamic> data = {};
    data.addAll(productModel.toMap());
    data['quantity'] = quantity;
    await FirebaseFirestore.instance
        .collection(MyCollections.userCollection)
        .doc(user.uid)
        .collection(MyCollections.cart)
        .doc(productModel.id)
        .set(data);
    return true;
  }
}

Future<void> decrementProductCart({String productID}) async {
  User user =  FirebaseAuth.instance.currentUser;

  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(user.uid)
      .collection(MyCollections.cart)
      .get()
      .then((value) => value.docs.forEach((doc) {
            if (doc.id == productID) {
              int quantity = doc.data()['quantity'];
              quantity--;
              doc.reference.update({'quantity': quantity});
            }
          }));
}

Future<dynamic> deleteProductFromCart(String productID, var ctx) async {
  User  user =  FirebaseAuth.instance.currentUser;

  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(user.uid)
      .collection(MyCollections.cart)
      .get()
      .then((value) => value.docs.forEach((doc) {
            if (doc.id == productID) {
              doc.reference.delete();
            }
          }));
  var cartCountProvider = Provider.of<CartCounterProvider>(ctx, listen: false);
  cartCountProvider.decrementCount();
}

Future<dynamic> getDefaultAddress() async {
  AddressModel addressModel;

  User  user =  FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(user.uid)
      .collection(MyCollections.address)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      if (element.data()['enabled'] == true) {
        addressModel =
            AddressModel.fromJson(id: element.id, json: element.data());
      }
    });
  });

  return addressModel;
}

Future<dynamic> getCartProducts() async {
  List<ProductModel> products = [];
  User  user =  FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(user.uid)
      .collection(MyCollections.cart)
      .get()
      .then((value) => value.docs.forEach((element) {
            products.add(ProductModel.fromJson(
                id: element.id, json: element.data()));
          }));
  return products;
}

Future<dynamic> getExtraVat() async {
  ExtraVatModel vatModel;
  await FirebaseFirestore.instance
      .collection(MyCollections.extraVat)
      .get()
      .then((value) => value.docs.forEach((element) {
            vatModel =
                ExtraVatModel(id: element.id, txt: element.data()['vat']);
          }));

  return vatModel;
}

Future<dynamic> checkPromoCode({String code}) async {
  bool founded = false;
  CouponModel couponModel;
  await FirebaseFirestore.instance
      .collection(MyCollections.coupon)
      .get()
      .then((value) => value.docs.forEach((doc) {
            if (doc.data()['coupon'] == code) {
              founded = true;
              couponModel = CouponModel(
                  id: doc.id,
                  coupon: doc.data()['coupon'],
                  description: doc.data()['description'],
                  discountValue: doc.data()['discountValue']);
            }
          }));

  if (founded == true) {
    return couponModel;
  }
  return false;
}

Future<dynamic> sendOrder(OrderModel orderModel) async {
  await Firestore.instance
      .collection(MyCollections.orders)
      .document()
      .setData(orderModel.toMap());
      
sendDashboardNotification();
      
}

Future<dynamic> clearCart(var ctx) async {
  User  user =  FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(user.uid)
      .collection(MyCollections.cart)
      .get()
      .then((value) => value.docs.forEach((element) {
            element.reference.delete();
          }));
  var cartCountProvider = Provider.of<CartCounterProvider>(ctx, listen: false);
  cartCountProvider.clearCartCounter();
}
