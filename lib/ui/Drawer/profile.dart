import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/authentication.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/userModel.dart';
import 'package:qutub_clinet/ui/Home/myCliper.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../colors.dart';

class Profile extends StatefulWidget {
  TextEditingController nameController;
  TextEditingController mailController;
  TextEditingController phoneController;
  UserModel userModel;
  Profile({this.userModel}) {
    nameController = TextEditingController(text: userModel.name);
    mailController = TextEditingController(text: userModel.email ?? "");
    phoneController = TextEditingController(text: userModel.phone);
  }

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File img;
  var profileKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      key: profileKey,
     body: SafeArea(
            child: Container(
        
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3-30 ,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipPath(
                        clipper: BezierClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColor.custGrey2,
                          ),
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                "Gladness",
                                style: TextStyle(
                                    fontFamily: 'italy',
                                    fontSize: 40,
                                    color: MyColor.customColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
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
                                          border: Border.all(
                                              color: MyColor.customColor)),
                                      child: ClipOval(
                                          child: (img != null)
                                              ? Image.file(
                                                  img,
                                                  fit: BoxFit.cover,
                                                )
                                              : (widget.userModel.profileImg ==
                                                      null)
                                                  ? Image.asset(
                                                      'assets/camera.png',
                                                      color:
                                                          MyColor.customColor,
                                                      scale: 4,
                                                    )
                                                  : Image.network(
                                                      widget
                                                          .userModel.profileImg,
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
                      )
                      ,Align(
                        alignment: Alignment.topLeft,
                        child:  IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: MyColor.customColor,
              
            ),
            onPressed: () => Navigator.pop(context)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                  children: [
                         CustomTextField(
                  controller: widget.nameController,
                  labelColor: MyColor.customColor,
                  txtColor: MyColor.customColor,
                  txtLablel: 'اسم المستخدم',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: widget.mailController,
                  labelColor: MyColor.customColor,
                  txtColor: MyColor.customColor,
                  txtLablel: 'البريد الألكتروني',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  isEditForProfile: true,
                  controller: widget.phoneController,
                  isEdit: false,
                  labelColor: MyColor.customColor,
                  txtColor: MyColor.customColor,
                  txtLablel: 'رقم التليفون',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  backgroundColor: MyColor.customColor,
                  textColor: MyColor.whiteColor,
                  txt: 'تعديل',
                  btnPressed: () async {
                    if (widget.nameController.text.isEmpty) {
                      showSnackbarError(
                          msg: 'من فضلك ادخل اسم المستخدم',
                          scaffoldKey: profileKey);
                      return;
                    }
                    widget.userModel.name = widget.nameController.text;
                    widget.userModel.email = widget.mailController.text;

                    showMyDialog(context: context, msg: 'جاري تحديث البيانات');
                    await updateUserInfo(widget.userModel, img).then((value) {
                      dismissDialog(context);
                      userProvider.setUser(widget.userModel);
                      Navigator.pop(context);
                    }).catchError((e) {
                      dismissDialog(context);
                      print('ErrorUpdateUserInfo:$e');
                    });
                  },
                )
             
                  ],
                )),
            ],
            ),
          ),
        ),
     ),
    );
  }
}
