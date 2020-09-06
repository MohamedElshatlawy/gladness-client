import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/addresses.dart';
import 'package:qutub_clinet/Providers/counrtyCodeProvider.dart';
import 'package:qutub_clinet/models/addressModel.dart';
import 'package:qutub_clinet/ui/colors.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/customTextField.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

class AddAddress extends StatelessWidget {
  var addressKey;
  AddAddress(this.addressKey);
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var countryCode = Provider.of<CountryCodeProvider>(context);
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Column(
        children: <Widget>[
          CustomTextField(
            labelColor: MyColor.customColor,
            txtLablel: 'عنوان جديد',
            lineCount: 2,
            txtColor: MyColor.customColor,
            controller: addressController,
          ),
          SizedBox(
            height: 15,
          ),
          CustomTextField(
            labelColor: MyColor.customColor,
            txtLablel: 'رقم التليفون',
            controller: phoneController,
            isCountryCode: true,
            isNumber: true,
            dropDownColor: MyColor.customColor,
            txtColor: MyColor.customColor,
          ),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            backgroundColor: MyColor.whiteColor,
            btnPressed: () async {
              if (phoneController.text.isEmpty ||
                  addressController.text.isEmpty) {
                showSnackbarError(
                    msg: 'قم بأدخال البيانات المطلوبة',
                    scaffoldKey: addressKey);
                return;
              }

              showMyDialog(context: context, msg: 'جاري تسجيل عنوان جديد');
              await insertNewAddress(AddressModel(
                      address: addressController.text,
                      isEnabled: true,
                      phone: countryCode.countryCode+ phoneController.text))
                  .then((value) {
                dismissDialog(context);
                phoneController.clear();
                addressController.clear();
              }).catchError((e) {
                dismissDialog(context);
                print("ErrorAddNewAddress:$e");
              });
            },
            textColor: MyColor.customColor,
            txt: 'اضافة عنوان',
          )
        ],
      ),
    );
  }
}
