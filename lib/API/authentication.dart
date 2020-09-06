import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/common.dart';
import 'package:qutub_clinet/models/userModel.dart';
import 'package:qutub_clinet/ui/Home/home.dart';
import 'package:qutub_clinet/ui/Login/completeData.dart';
import 'package:qutub_clinet/ui/Login/pinCode.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

Future<void> loginUser({String phone, var context}) async {
  bool sentMsg = false;
  FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 30),
      verificationCompleted: (authCredential) async {
        print('Completed');

        if (sentMsg == false) {
          //getUserInfo and navigate to home
          var authResult =
              await FirebaseAuth.instance.signInWithCredential(authCredential);
          await navigateToHome(authResult, context);
        }
      },
      verificationFailed: (authException) {
        dismissDialog(context);
        print('ErroVerfication:${authException.message}');
      },
      codeSent: (verficationCode, [int codeSent]) {
        dismissDialog(context);
        sentMsg = true;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => PinCode(
                      verificationCode: verficationCode,
                    )));
      },
      codeAutoRetrievalTimeout: (timeOut) {});
}

Future<UserModel> getUserInfo(User user, var ctx) async {
  UserModel userModel;
  await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(user.uid)
      .get()
      .then((value) {
    // print('SnapShot:${value.data}');
    if (value.data != null) {
      userModel =
          UserModel.fromJson(value.data(), value.id, user.phoneNumber);
    }

  }).catchError((e){
    return null;
  });

  return userModel;
}
//////////////////////////////////////////////////////////////////////////////

Future<void> navigateToHome(var authResult, var ctx) async {
  dismissDialog(ctx);
  UserModel userModel = await getUserInfo(authResult.user, ctx);
  //print('UserModel:${userModel.name}');
  if (userModel == null) {
    print('UserIsNull----------------------');
    Navigator.of(ctx).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
            builder: (ctx) => CompleteData(
                  userId: authResult.user.uid,
                  phone: authResult.user.phoneNumber,
                )));
  } else {

    print('UserNotNull----------------------');
    var userProvider = Provider.of<UserProvider>(ctx, listen: false);
    userProvider.setUser(userModel);
    Navigator.of(ctx).popUntil((route) => route.isFirst);
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => MainHome()));
  }
}

////////////////////////////////////////////////////////////////////////////////

Future<void> varifySMS({String sms, String verfCode, var ctx}) async {
  print('smsCode:$sms');
  print('VerfCode:$verfCode');
//dismissDialog(ctx);
  var authCredential =
      PhoneAuthProvider.credential(verificationId: verfCode, smsCode: sms);
  await FirebaseAuth.instance
      .signInWithCredential(authCredential)
      .then((result) async {
        print('Result:${result.user.phoneNumber}');
    await navigateToHome(result, ctx);
  }).catchError((e){
    print('ErrorVerify:$e');
  });
}

Future<dynamic> registerUser(
    {String userID,
    String userName,
    String email,
    String phone,
    File profileImg,
    var ctx}) async {
  String imgURL;
  if (profileImg != null) {
    final StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(MyCollections.images)
        .child(basename(profileImg.path));

    await storageReference
        .putFile(profileImg)
        .onComplete
        .then((taskSnap) async {
      imgURL = await taskSnap.ref.getDownloadURL();
    });
  }
    await FirebaseFirestore.instance
        .collection(MyCollections.userCollection)
        .doc(userID)
        .set(UserModel(email: email, name: userName, profileImg: imgURL)
            .toMap());

   
  }


//CheckUserLogin
Future<dynamic> checkUserLoggedIn() async {
  User user =  FirebaseAuth.instance.currentUser;
  //print('User:${user.phoneNumber}');
  if (user == null) {
    return false;
  }
  var doc = await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(user.uid)
      .get();
  return UserModel.fromJson(doc.data(), user.uid, user.phoneNumber);
}

//userLogout
Future<dynamic> logoutUser() async {
  var status;
  await FirebaseAuth.instance.signOut().then((value) => status = true);

  return status;
}

Future<void> updateUserInfo(UserModel model, File img) async {
  if (img != null) {
//upload image
    String imageURL = "";
    final StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(MyCollections.images)
        .child(basename(img.path));

    await storageReference.putFile(img).onComplete.then((taskSnap) async {
      imageURL = await taskSnap.ref.getDownloadURL();
      model.profileImg = imageURL;
    });
  }
  //updateCategoryNewImg
  return await FirebaseFirestore.instance
      .collection(MyCollections.userCollection)
      .doc(model.userToken)
      .update(model.toMap());
}
