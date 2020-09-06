import 'package:flutter/material.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';

import '../colors.dart';

class AddUser extends StatelessWidget {
  var userController = TextEditingController();
  var passController = TextEditingController();
  var confPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      appBar: AppBar(
        backgroundColor: MyColor.customColor,
        title: Text('اضافة مستخدم'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/profile.png',
                  scale: 2.9,
                  color: MyColor.customColor,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: userController,
                  txtLablel: 'اسم مستخدم جديد',
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: passController,
                  txtLablel: 'الرقم السري',
                  isPassword: true,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: confPassController,
                  isPassword: true,
                  txtLablel: 'تأكيد الرقم السري',
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  backgroundColor: Colors.grey[200],
                  textColor: MyColor.customColor,
                  txt: 'انشاء حساب',
                  btnPressed: () {
                    /*  if (mailController.text.isNotEmpty &&
                                   passController.text.isNotEmpty &&
                                   confirmPassController.text.isNotEmpty) {
                                 if (confirmPassController.text.isNotEmpty &&
                                     passController.text ==
                                         confirmPassController.text) {
                                   //create admin
                                   setState(() {
                                     signUpProgress=true;
                                   });

                                   signUp(mailController.text, passController.text).then((res){
                                     showSnackMsg('Admin created successfully !');
                                     mailController.clear();
                                     passController.clear();
                                     confirmPassController.clear();

                                   }).catchError((e){
                                     showSnackMsg(e.toString());
                                   })
                                   .whenComplete((){
                                     setState(() {
                                       signUpProgress=false;
                                     });
                                   });

                                 } else {
                                   showSnackMsg('Password not matched !');
                                 }
                               } else {
                                 showSnackMsg('Fill all fields !');
                               }*/
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
