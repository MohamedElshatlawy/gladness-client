import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:qutub_clinet/API/authentication.dart';
import 'package:qutub_clinet/ui/Home/home.dart';
import 'package:qutub_clinet/ui/Login/completeData.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../colors.dart';

class PinCode extends StatelessWidget {
  String verificationCode;
  PinCode({this.verificationCode});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Container(
            
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'قم بأدخال رمز التحقق',
                  style: TextStyle(fontSize: 28, color: MyColor.customColor),
                ),
                SizedBox(
                  height: 60,
                ),
                PinCodeTextField(
                  autofocus: true,
                  pinBoxOuterPadding: EdgeInsets.only(right: 6,top: 6),
                  pinBoxWidth: MediaQuery.of(context).size.width*.14,
                  pinBoxHeight: 48,
                  highlight: true,
                  pinBoxBorderWidth: 1.5,
                  highlightColor: MyColor.customColor,
                  defaultBorderColor: MyColor.customColor,
                  hasTextBorderColor: Colors.green,
                  maxLength: 6,

                  onTextChanged: (text) {},
                  onDone: (text) async {
                    showMyDialog(
                      context: context,
                      msg: 'حاري ارسال رمز التحقق'
                    ); 
                    await varifySMS(
                      ctx: context,
                      sms: text,
                      verfCode: verificationCode
                    ).catchError((e){
                      dismissDialog(context);
                      print('ErrorVerifyCode:$e');
                    });
                    /*
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => CompleteData()));*/
                  },
                  pinBoxRadius: 6,

                  wrapAlignment: WrapAlignment.center,
                  pinTextStyle:
                      TextStyle(fontSize: 20.0, color: MyColor.customColor),
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
//                    highlightAnimation: true,
                  highlightAnimationBeginColor: Colors.black,
                  highlightAnimationEndColor: Colors.white12,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
