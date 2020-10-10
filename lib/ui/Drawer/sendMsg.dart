import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/msgModel.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../Locale/appLocalization.dart';
import '../../Locale/localizationProvider.dart';

class SendMsg extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var mailController = TextEditingController();
  var msgController = TextEditingController();
  var msgKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    var local = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      key: msgKey,
      appBar: AppBar(
        backgroundColor: MyColor.whiteColor,
        title: Text(
          local.translate('contact_us'),
          style: TextStyle(color: MyColor.customColor),
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColor.customColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  (local.locale.languageCode=="en")?"Thanks for contact us":
                  'شكرا لتواصلك معانا',
                  style: TextStyle(color: MyColor.customColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      '${local.translate('phone')} :',
                      style: TextStyle(color: MyColor.customColor),
                    ),
                  ],
                ),
                // CustomTextField(
                //   controller: nameController,
                //   txtLablel: 'الأسم',
                //   txtColor: Colors.grey,
                //   labelColor: MyColor.customColor,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: phoneController,
                  isNumber: true,
                  isSendMsgPhone: true,
                  txtColor: Colors.grey,
                  labelColor: MyColor.customColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      ' ${local.translate('msg_content')} :',
                      style: TextStyle(color: MyColor.customColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // CustomTextField(
                //   controller: mailController,
                //   isMail: true,
                //   txtLablel: 'البريد الألكتروني',
                //   txtColor: Colors.grey,
                //   labelColor: MyColor.customColor,
                // ),
                // SizedBox(
                //   height: 10,
                // ),

                CustomTextField(
                  controller: msgController,
                  lineCount: 12,
                  isSendMsgPhone: true,
                  //txtLablel: 'الرسالة',
                  txtColor: Colors.grey,
                  labelColor: MyColor.customColor,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 120,
                  child: RaisedButton(
                    onPressed: () async {
                      if (phoneController.text.isEmpty ||
                          msgController.text.isEmpty) {
                        showSnackbarError(
                            msg: 
                            (local.locale.countryCode=="en")?"Fill All fields":
                            'ادخل البيانات كاملة', scaffoldKey: msgKey);
                        return;
                      }
                      var msgModel = MsgModel(
                          mail: userProvider.userModel.email,
                          msg: msgController.text,
                          name: userProvider.userModel.name,
                          phone: phoneController.text);
                      showMyDialog(context: context, msg: 
                       (local.locale.countryCode=="en")?"Sending message":
                      'جاري ارسال الرسالة');
                      await FirebaseFirestore.instance
                          .collection("messages")
                          .doc()
                          .set(msgModel.toMap())
                          .then((value) {
                        dismissDialog(context);
                        Fluttertoast.showToast(
                            msg: 
                             (local.locale.countryCode=="en")?"Messega sent successfully":
                            "تم الأرسال بنجاح",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromRGBO(43, 188, 177, 1),
                            textColor: Colors.white,
                            fontSize: 16.0);

                        sendDashboardNotification();
                        nameController.clear();
                        phoneController.clear();
                        mailController.clear();
                        msgController.clear();
                      }).catchError((e) {
                        dismissDialog(context);
                        showSnackbarError(
                            msg: 
                             (local.locale.countryCode=="en")?"Error Connection":
                            'حدث خطأ في الأرسال حاول مرة اخرى',
                            scaffoldKey: msgKey);
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: MyColor.customColor,
                    textColor: Colors.white,
                    child: Text(
                       local.translate('send')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> sendDashboardNotification() async {
    await FirebaseFirestore.instance
        .collection(MyCollections.dashBoardUsers)
        .get()
        .then((value) async {
      print('DocsValue:${value.docs.length}');

      Future.forEach(value.docs, (element) async {
        if (element.data()['fcm_token'] != null) {
          print('Token:${element.data()['fcm_token']}');
          await sendToAllClients(element.data()['fcm_token'], 'رسالة جديدة');
        }
      });
    });
  }
}
