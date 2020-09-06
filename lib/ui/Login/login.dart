import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/authentication.dart';
import 'package:qutub_clinet/Providers/counrtyCodeProvider.dart';
import 'package:qutub_clinet/ui/Home/home.dart';
import 'package:qutub_clinet/ui/Login/completeData.dart';
import 'package:qutub_clinet/ui/Login/pinCode.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../colors.dart';

class Login extends StatelessWidget {
  var loginKey = GlobalKey<ScaffoldState>();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var countryProvider = Provider.of<CountryCodeProvider>(context);
    return Scaffold(
      key: loginKey,
      backgroundColor: MyColor.customGreyColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Gladness',
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: 'italy',
                        //fontWeight: FontWeight.w600,
                        color: MyColor.customColor),
                  ),
                  
                  // Image.asset(
                  //   'assets/logo.png',
                  //   scale: 8,
                  // ),

                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'لوحة التحكم',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                            color:  MyColor.whiteColor),
                      )
                    ],
                  ),*/
                  SizedBox(
                    height: 35,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    isNumber: true,
                    txtLablel: 'رقم التليفون',
                    isCountryCode: true,
                    txtColor: MyColor.customColor,
                    labelColor: MyColor.customColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    txt: 'تسجيل دخول',
                    textColor: MyColor.customGreyColor,
                    backgroundColor: MyColor.customColor,
                    btnPressed: () async {
                      if (validateInpur()) {
                         showMyDialog(
                          context: context,
                          msg: 'جاري تسجيل الدخول'
                        );
                       await loginUser(
                            context: context,
                            phone: countryProvider.countryCode +
                                phoneController.text);
                      }
                    
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateInpur() {
    if (phoneController.text.isEmpty) {
      showSnackbarError(
          msg: 'من فضلك ادخل رقم التليفون', scaffoldKey: loginKey);
      return false;
    }
    return true;
  }
}
