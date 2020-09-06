import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:qutub_clinet/models/productModel.dart';

import 'CommonCollections.dart';

Future<List<String>> uploadProductsImages(List<File> images) async {
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

Future<void> insertNewProduct(
    {ProductModel productModel, List<File> imgs}) async {
  //upload image

  List<String> paths = await uploadProductsImages(imgs);

//  productModel.imgPaths = paths;

  //AddNewProduct
  return await FirebaseFirestore.instance
      .collection(MyCollections.products)
      .doc()
      .set(productModel.toMap());
}
Future<void> removeProduct(ProductModel productModel) async {
  return await FirebaseFirestore.instance
      .collection(MyCollections.products)
      .doc(productModel.id)
      .delete();
}
Future<List<ProductModel>> getAllProductsFire(String catID) async {
  List<ProductModel> products = [];

  await FirebaseFirestore.instance
      .collection(MyCollections.products)
      .where('categoryID', isEqualTo: catID)
      .get()
      .then((value) => value.docs.forEach((element) {
            products.add(ProductModel.fromJson(
                id: element.id, json: element.data()));
          }));

  return products;
}


Future<void> updateProduct({ProductModel productModel, List<File> imgs}) async {
  var newPathsFiles;
  if(imgs.isNotEmpty){
   newPathsFiles=await uploadProductsImages(imgs);
  }

  List<String> newProductPaths=[];
  
  // //
  // productModel.imgPaths.forEach((element) { 
  //   newProductPaths.add(element);
  // });
  if(newPathsFiles!=null){
      newProductPaths.addAll(newPathsFiles);
  }
  //

  await removeProduct(productModel);

 // productModel.imgPaths.clear();
  //productModel.imgPaths.addAll(newProductPaths);
  
  return await FirebaseFirestore.instance
      .collection(MyCollections.products)
      .doc()
      .set(productModel.toMap());
}