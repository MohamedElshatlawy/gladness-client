import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future getImage() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery,
  imageQuality: 85
  );

  return image;
}

showSnackbarError({var scaffoldKey, String msg}) {

  scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Flexible(
                      child: Text(
    checkErrorType(msg),
    style: TextStyle(fontFamily: 'ar'),
    textAlign: TextAlign.right,
  ),
          ),
        ],
      )));
}

showMyDialog({var context, String msg}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
            content: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  width: 25,
                ),
                Text(msg)
              ],
            ),
          ));
}

dismissDialog(var context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}

String checkErrorType(String e) {
  switch (e) {
    case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':
      return 'حدث خطأ في الاتصال بالأنترنت';

    case 'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)':
    case 'PlatformException(ERROR_INVALID_EMAIL, The email address is badly formatted., null)':
    case 'PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null)':
      return 'يوجد خطأ في ادخال البيانات';
  }
  return e;
}
