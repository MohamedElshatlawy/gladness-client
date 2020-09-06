import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/models/msgModel.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

class SendMsg extends StatelessWidget {
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var mailController=TextEditingController();
  var msgController=TextEditingController();
  var msgKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      key: msgKey,
      appBar: AppBar(
        backgroundColor: MyColor.whiteColor,
        title: Text('تواصل معنا',style: TextStyle(
          color: MyColor.customColor
        ),),
        centerTitle: true,
      leading: IconButton(icon: Icon(Icons.arrow_back_ios,
      color: MyColor.customColor,
      ), onPressed: (){
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
            CustomTextField(
                  controller: nameController,
                  txtLablel: 'الأسم',
                  txtColor: Colors.grey,
                  labelColor: MyColor.customColor,
            ),
            SizedBox(height: 10,),
             CustomTextField(
                  controller: phoneController,
                  isNumber: true,
                  txtLablel: 'التليفون',
                  txtColor: Colors.grey,
                  labelColor: MyColor.customColor,
            ),
               SizedBox(height: 10,),
             CustomTextField(
                  controller: mailController,
               isMail: true,
                  txtLablel: 'البريد الألكتروني',
                  txtColor: Colors.grey,
                  labelColor: MyColor.customColor,
            ),
               SizedBox(height: 10,),
             CustomTextField(
                  controller: msgController,
                  lineCount: 6,
                  txtLablel: 'الرسالة',
                  txtColor: Colors.grey,
                  labelColor: MyColor.customColor,
            ),
              SizedBox(height: 25,),
              CustomButton(
                  btnPressed: () async {
                    if(nameController.text.isEmpty||phoneController.text.isEmpty||
                    mailController.text.isEmpty||msgController.text.isEmpty
                    ){
                      showSnackbarError(
                        msg: 'ادخل البيانات كاملة',
                        scaffoldKey: msgKey
                      );
                      return;
                    }
                    var msgModel=MsgModel(
                      mail: mailController.text,
                      msg: msgController.text,
                      name: nameController.text,
                      phone: phoneController.text
                    );
                    showMyDialog(
                      context: context,
                      msg: 'جاري ارسال الرسالة'
                    );
                    await FirebaseFirestore.instance.collection("messages")
                    .doc().set(msgModel.toMap()).then((value){
                      dismissDialog(context);
                     showSnackbarError(
                        msg: 'تم الأرسال بنجاح',
                        scaffoldKey: msgKey
                      );
                      sendDashboardNotification();
                      nameController.clear();
                      phoneController.clear();
                      mailController.clear();
                      msgController.clear();
                    }).catchError((e){
                      dismissDialog(context);
                       showSnackbarError(
                        msg: 'حدث خطأ في الأرسال حاول مرة اخرى',
                        scaffoldKey: msgKey
                      );
                    });

                  },
                  backgroundColor: MyColor.customColor,
                  textColor: Colors.white,
                  txt: 'إرسال',
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