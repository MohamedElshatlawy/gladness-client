import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:qutub_clinet/models/categoryModel.dart';

import 'CommonCollections.dart';

Future<void> insertNewCategory({File img, String categoryName}) async {
  //upload image
  String imageURL = "";
  final StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child(MyCollections.images)
      .child(basename(img.path));

  await storageReference.putFile(img).onComplete.then((taskSnap) async {
    imageURL = await taskSnap.ref.getDownloadURL();
  });

  //AddNewCategory
  return await FirebaseFirestore.instance
      .collection(MyCollections.categories)
      .doc()
      .set(CategoryModel(imgPath: imageURL, name: categoryName).toMap());
}

Future<void> updateNewCategory({File img, CategoryModel categoryModel}) async {
  if (categoryModel.imgPath == null) {
//upload image
    String imageURL = "";
    final StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(MyCollections.images)
        .child(basename(img.path));

    await storageReference.putFile(img).onComplete.then((taskSnap) async {
      imageURL = await taskSnap.ref.getDownloadURL();
    });

    //updateCategoryNewImg
    return await FirebaseFirestore.instance
        .collection(MyCollections.categories)
        .doc(categoryModel.id)
        .update(
            CategoryModel(imgPath: imageURL, name: categoryModel.name).toMap());
  }

  //updateCategoryName
  return await FirebaseFirestore.instance
      .collection(MyCollections.categories)
      .doc(categoryModel.id)
      .update(CategoryModel(
              imgPath: categoryModel.imgPath, name: categoryModel.name)
          .toMap());
}

Future<void> removeCategory(CategoryModel categoryModel) async {
  await removeProductRelatedToCategory(categoryModel.id);
  
  return await FirebaseFirestore.instance
      .collection(MyCollections.categories)
      .doc(categoryModel.id)
      .delete();
}
Future<void> removeProductRelatedToCategory(String catID) async {
  return await FirebaseFirestore.instance
      .collection(MyCollections.products)
      .where('categoryID',
      isEqualTo: catID
      ).get().then((value) => value.docs.forEach((element) async { 

        await element.reference.delete();
      }));
}
Future<List<CategoryModel>> getAllCateogriesFireStore() async {
  List<CategoryModel> cats = [];
  await FirebaseFirestore.instance
      .collection(MyCollections.categories)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      cats.add(CategoryModel(
          id: element.id,
          imgPath: element.data()['imgPath'],
          name: element.data()['name']));
    });
  });

  return cats;
}
