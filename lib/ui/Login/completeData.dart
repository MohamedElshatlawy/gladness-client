import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/authentication.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/userModel.dart';
import 'package:qutub_clinet/ui/Home/home.dart';
import 'package:qutub_clinet/ui/Login/login.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

class CompleteData extends StatefulWidget {
  String userId;
  String phone;
  CompleteData({this.userId, this.phone});
  @override
  _CompleteDataState createState() => _CompleteDataState();
}

class _CompleteDataState extends State<CompleteData> {
  var nameController = TextEditingController();
  var mailController = TextEditingController();
  File img;
  var completeInfoKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: completeInfoKey,
      backgroundColor: MyColor.customGreyColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'استكمال البيانات',
                  style: TextStyle(fontSize: 30, color: MyColor.customColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: <Widget>[
                      Center(
                          child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: MyColor.customColor)),
                              child: ClipOval(
                                  child: (img != null)
                                      ? Image.file(
                                          img,
                                          fit: BoxFit.cover,
                                        )
                                      : (img == null)
                                          ? Image.asset(
                                              'assets/camera.png',
                                              color: MyColor.customColor,
                                              scale: 4,
                                            )
                                          : Image.file(
                                              img,
                                              fit: BoxFit.cover,
                                            )))),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          child: InkWell(
                            onTap: () async {
                              img = await getImage();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.red[800],
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelColor: MyColor.customColor,
                  txtLablel: 'الأسم بالكامل',
                  txtColor: MyColor.customColor,
                  controller: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelColor: MyColor.customColor,
                  txtLablel: 'البريد الألكتروني',
                  txtColor: MyColor.customColor,
                  controller: mailController,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  backgroundColor: MyColor.whiteColor,
                  textColor: MyColor.customColor,
                  txt: 'تأكيد',
                  btnPressed: () async {
                    if (validateInputs()) {
                      showMyDialog(
                          context: context, msg: 'جاري تحديث البيانات');
                      await registerUser(
                              email: (mailController.text.isEmpty)
                                  ? null
                                  : mailController.text,
                              userName: nameController.text,
                              profileImg: img,
                              userID: widget.userId,
                              phone: widget.phone,
                              ctx: context)
                          .catchError((e) {
                        dismissDialog(context);
                        print('ErrorUserRegister:$e');
                      }).then((value) {
                        dismissDialog(context);
                      });
                      await checkUserLoggedIn().then((value) {
                        if (value == false) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) => Login()));
                        } else {
                          var userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          userProvider.setUser(value);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx) => MainHome()));
                        }
                      }).catchError((e) {
                        showSnackbarError(
                            msg: 'حدث خطأ في الأتصال.حاول مرة اخرى',
                            scaffoldKey: completeInfoKey);
                      });
                    }
                    /*   Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => MainHome()));*/
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateInputs() {
    if (nameController.text.isEmpty) {
      showSnackbarError(
          msg: 'من فضلك ادخل الأسم', scaffoldKey: completeInfoKey);
      return false;
    }
     if (mailController.text.isEmpty) {
      showSnackbarError(
          msg: 'من فضلك ادخل البريد الألكتروني', scaffoldKey: completeInfoKey);
      return false;
    }
    return true;
  }
}
