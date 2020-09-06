import 'package:flutter/material.dart';

import '../colors.dart';

class CustomPhoneContactUS extends StatelessWidget {
  String phoneNumber;
  CustomPhoneContactUS({this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.phone_android,
        color: MyColor.customColor,
        size: 25,
      ),
      title: Text(
        phoneNumber,
        style: TextStyle(color: MyColor.customColor, fontSize: 16),
      ),
    );
  }
}
