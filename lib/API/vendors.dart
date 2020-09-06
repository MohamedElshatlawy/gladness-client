import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/models/vendorModel.dart';

import 'CommonCollections.dart';

Future<List<String>> uploadVendorsPriceListImages(List<File> images) async {
  List<String> imagesURL = [];

  await Future.forEach(images, (File myImage) async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child(MyCollections.images)
        .child(basename(myImage.path));

    await storageReference.putFile(myImage).onComplete.then((taskSnap) async {
      imagesURL.add(await taskSnap.ref.getDownloadURL());
    });
  });

  return imagesURL;
}

Future<void> insertNewVendor(
    {Map<String, String> priceList,
    List<File> gallery,
    VendorModel vendorModel,
    File profileImg,
    List<String> regularHolidays,
    Map<String, Map<String, String>> nonRegulars}) async {
  //UploadGalleryImages
  List<String> paths = await uploadVendorsPriceListImages(gallery);

  //upload Profileimage
  String imageURL = "";
  final StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child(MyCollections.images)
      .child(basename(profileImg.path));

  await storageReference.putFile(profileImg).onComplete.then((taskSnap) async {
    imageURL = await taskSnap.ref.getDownloadURL();
  });
  vendorModel.imgPath = imageURL;

  //AddHolidays
  vendorModel.regularHolidays = regularHolidays;
  vendorModel.nonRegulars = nonRegulars;

  String vendorID = "";

  //AddNewVendor
  var doc = FirebaseFirestore.instance.collection(MyCollections.vendors).doc();

  await doc.set(vendorModel.toMap());

  //AddProducts
  vendorID = doc.documentID;
  // Map<String, String> priceList = {};
  // for (int i = 0; i < paths.length; i++) {
  //   priceList[paths[i]] = images.values.toList()[i];
  // }
  FirebaseFirestore.instance.collection(MyCollections.products).doc().set(
      ProductModel(
              categoryId: vendorModel.categoryID,
              categoryName: vendorModel.categoryName,
              vendorID: vendorID,
              vendorName: vendorModel.name,
              priceList: priceList,
              galleryPaths: paths
              )
          .toMap());
}

//remove vendor
Future<void> removeVendor(VendorModel vendorModel) async {
  await removeProductRelatedToVendor(vendorModel.id);
  return await FirebaseFirestore.instance
      .collection(MyCollections.vendors)
      .doc(vendorModel.id)
      .delete();
}

Future<void> removeProductRelatedToVendor(String vendorID) async {
  return await FirebaseFirestore.instance
      .collection(MyCollections.products)
      .where('vendorID', isEqualTo: vendorID)
      .get()
      .then((value) => value.docs.forEach((element) async {
            await element.reference.delete();
          }));
}

//getAllVendors on category
Future<List<VendorModel>> getAllVendorsFromCategory(String catID) async {
  List<VendorModel> vendors = [];

  await FirebaseFirestore.instance
      .collection(MyCollections.vendors)
      .where('categoryID', isEqualTo: catID)
      .get()
      .then((value) => value.docs.forEach((element) {
            vendors.add(VendorModel.fromJson(
                id: element.documentID, json: element.data()));
          }));

  return vendors;
}

//update vendor

Future<void> updateVendor({VendorModel vendorModel, File img}) async {
  if (vendorModel.imgPath == null) {
//upload image
    String imageURL = "";
    final StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(MyCollections.images)
        .child(basename(img.path));

    await storageReference.putFile(img).onComplete.then((taskSnap) async {
      imageURL = await taskSnap.ref.getDownloadURL();
    });

    //updateVendorNewImg
    return await FirebaseFirestore.instance
        .collection(MyCollections.vendors)
        .doc(vendorModel.id)
        .update(VendorModel(
          bio: vendorModel.bio,
          categoryName: vendorModel.categoryName,
          categoryID: vendorModel.categoryID,
          commRec: vendorModel.commRec,
          email: vendorModel.email,
          imgPath: imageURL,
          name: vendorModel.name,
          optionalPhone: vendorModel.optionalPhone,
          phone: vendorModel.phone,
        ).toMap());
  }

  //updateVendor
  return await FirebaseFirestore.instance
      .collection(MyCollections.vendors)
      .doc(vendorModel.id)
      .update(VendorModel(
        bio: vendorModel.bio,
        categoryName: vendorModel.categoryName,
        categoryID: vendorModel.categoryID,
        commRec: vendorModel.commRec,
        email: vendorModel.email,
        imgPath: vendorModel.imgPath,
        name: vendorModel.name,
        optionalPhone: vendorModel.optionalPhone,
        phone: vendorModel.phone,
      ).toMap());
}


Future<void> updateVendorsHolidays(VendorModel vendorModel)async{
   return await FirebaseFirestore.instance
        .collection(MyCollections.vendors)
        .doc(vendorModel.id)
        .update({
          "non_regular_holidays":vendorModel.nonRegulars,
          "regular_holidays":vendorModel.regularHolidays
        });
}