import 'package:flutter/material.dart';
import 'package:qutub_clinet/ui/colors.dart';

class Common{
  static String domainName="@qutub.com";
  static String reviewStatus="review";
  static String acceptedStatus="accept";
  static String rejectedStatus="reject";
  static String confirmedStatus="confirm";

  static var mappingColors={
    reviewStatus:MyColor.customColor,
    rejectedStatus:Colors.red[800],
    acceptedStatus:Colors.blueGrey,
    confirmedStatus:Colors.green[600]
  };

  static var mappingStatus={
    reviewStatus:'تم استلام الطلب',
    rejectedStatus:'الطلب مرفوض',
    acceptedStatus:'تحت المراجعة',
    confirmedStatus:'تم قبول الطلب'
  };
}