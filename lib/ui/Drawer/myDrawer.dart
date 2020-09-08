import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/API/authentication.dart';
import 'package:qutub_clinet/FCM/fcmConfig.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/NotificationModel.dart';
import 'package:qutub_clinet/ui/Drawer/addAboutUs.dart';
import 'package:qutub_clinet/ui/Drawer/addCategory.dart';
import 'package:qutub_clinet/ui/Drawer/addCoupon.dart';
import 'package:qutub_clinet/ui/Drawer/addUser.dart';
import 'package:qutub_clinet/ui/Drawer/address/addresses.dart';
import 'package:qutub_clinet/ui/Drawer/notifications.dart';
import 'package:qutub_clinet/ui/Drawer/profile.dart';
import 'package:qutub_clinet/ui/Drawer/sendMsg.dart';
import 'package:qutub_clinet/ui/Login/login.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../colors.dart';
import 'addContactUs.dart';
import 'addProduct.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: Container(
        color: MyColor.customGreyColor,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: Center(
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: MyColor.customColor)),
                          child: ClipOval(
                              child: (userProvider.userModel == null ||
                                      userProvider.userModel.profileImg == null)
                                  ? Image.asset(
                                      'assets/profile.png',
                                      color: MyColor.customColor,
                                      scale: 4,
                                    )
                                  : Image.network(
                                      userProvider.userModel.profileImg,
                                      fit: BoxFit.cover,
                                    )))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${userProvider.userModel.name}',
                  style: TextStyle(color: MyColor.customColor),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => Profile(
                                  userModel: userProvider.userModel,
                                )));
                  },
                  leading: Icon(
                    Icons.person_pin,
                    size: 25,
                    color: MyColor.customColor,
                  ),
                  title: Text(
                    'الحساب الشخصي',
                    style: TextStyle(color: MyColor.customColor),
                  ),
                ),
                Divider(
                  endIndent: 30,
                  indent: 30,
                  color: MyColor.whiteColor,
                ),
                // ListTile(
                //   onTap: () {
                //     seenNotification();
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (ctx) => AddNotification()));
                //   },
                //   leading: Icon(
                //     Icons.notifications_active,
                //     size: 20,
                //     color: MyColor.whiteColor,
                //   ),
                //   trailing: Container(
                //     width: 20,
                //     height: 20,
                //     child: StreamBuilder<QuerySnapshot>(
                //       stream:FirebaseFirestore.instance
                //           .collection(MyCollections.userCollection)
                //           .doc(userProvider.userModel.userToken)
                //           .collection(MyCollections.notification)
                //           .snapshots(),
                //       builder: (ctx, AsyncSnapshot<QuerySnapshot> snapSHot) {
                //         if (snapSHot.hasError) return Container();
                //         switch (snapSHot.connectionState) {
                //           case ConnectionState.waiting:
                //           case ConnectionState.none:
                //             return Container();
                //           case ConnectionState.active:

                //           case ConnectionState.done:
                //             int count = 0;
                //             snapSHot.data.docs.forEach((element) {
                //               if (element.data()['seen'] == false) {
                //                 count++;
                //               }
                //             });
                //             return (snapSHot.data.docs.isEmpty||count==0)
                //                 ? Container()
                //                 : Container(
                //                     decoration: BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         color: Colors.red[800]),
                //                     child: Center(
                //                       child: Text(
                //                         '$count',
                //                         style: TextStyle(
                //                             color: MyColor.whiteColor),
                //                       ),
                //                     ),
                //                   );
                //         }
                //         return Container();
                //       },
                //     ),
                //   ),
                  
                  
                //   title: Text(
                //     'الأشعارات',
                //     style: TextStyle(color: MyColor.whiteColor),
                //   ),
                // ),
                // Divider(
                //   endIndent: 30,
                //   indent: 30,
                //   color: MyColor.whiteColor,
                // ),
                ListTile(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (ctx)=>SendMsg()));
                  },
                  leading: Icon(
                    Icons.message,
                    size: 20,
                    color: MyColor.customColor,
                  ),
                  title: Text(
                    'ارسال رسالة',
                    style: TextStyle(color: MyColor.customColor),
                  ),
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (ctxt) => MyAddresses()));
                //   },
                //   leading: Icon(
                //     Icons.add_location,
                //     size: 20,
                //     color: MyColor.whiteColor,
                //   ),
                //   title: Text(
                //     'عناوين التوصيل',
                //     style: TextStyle(color: MyColor.whiteColor),
                //   ),
                // ),
               
                Divider(
                  endIndent: 30,
                  indent: 30,
                  color: MyColor.customColor,
                ),
                /* ListTile(
                  onTap: () {
                    /*   Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => AddAboutUs()));*/
                  },
                  leading: Icon(
                    Icons.settings,
                    size: 20,
                    color: MyColor.whiteColor,
                  ),
                  title: Text(
                    'الأعدادات',
                    style: TextStyle(color: MyColor.whiteColor),
                  ),
                ),
                Divider(
                  endIndent: 30,
                  indent: 30,
                  color: MyColor.whiteColor,
                ),*/
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => AddAboutUs()));
                  },
                  leading: Icon(
                    Icons.description,
                    size: 20,
                    color: MyColor.customColor,
                  ),
                  title: Text(
                    'نبذة عنا',
                    style: TextStyle(color: MyColor.customColor),
                  ),
                ),
                Divider(
                  endIndent: 30,
                  indent: 30,
                  color: MyColor.customColor,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctxt) => AddContactUs()));
                  },
                  leading: Icon(
                    Icons.phone_android,
                    size: 20,
                    color: MyColor.customColor,
                  ),
                  title: Text(
                    'ارقام التواصل',
                    style: TextStyle(color: MyColor.customColor),
                  ),
                ),
                Divider(
                  endIndent: 30,
                  indent: 30,
                  color: MyColor.customColor,
                ),
                ListTile(
                  onTap: () async {
                    showMyDialog(context: context, msg: 'جاري تسجيل الخروج');
                    await logoutUser().then((value) {
                      dismissDialog(context);
                      if (value == true) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => Login()));
                      }
                    }).catchError((e) {
                      dismissDialog(context);
                      print('ErrorLogout:$e');
                    });
                  },
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 20,
                    color: MyColor.customColor,
                  ),
                  title: Text(
                    'تسجيل خروج',
                    style: TextStyle(color: MyColor.customColor),
                  ),
                ),
              ],
            ),
       
       
       
          ),
        ),
      ),
   
   
    );
  }
}
