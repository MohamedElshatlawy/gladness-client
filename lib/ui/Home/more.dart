import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/authentication.dart';
import 'package:qutub_clinet/Locale/appLocalization.dart';
import 'package:qutub_clinet/Locale/localizationProvider.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/ui/Drawer/addAboutUs.dart';
import 'package:qutub_clinet/ui/Drawer/addContactUs.dart';
import 'package:qutub_clinet/ui/Drawer/profile.dart';
import 'package:qutub_clinet/ui/Drawer/sendMsg.dart';
import 'package:qutub_clinet/ui/Login/login.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../colors.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool arEnabled = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var local = AppLocalizations.of(context);

    var locProvider = Provider.of<LocalProvider>(context);
    print(local.locale.languageCode);

    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   width: 100,
                //   height: 100,
                //   child: Center(
                //       child: Container(
                //           width: 100,
                //           height: 100,
                //           decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               border: Border.all(color: MyColor.customColor)),
                //           child: ClipOval(
                //               child: (userProvider.userModel == null ||
                //                       userProvider.userModel.profileImg ==
                //                           null)
                //                   ? Image.asset(
                //                       'assets/profile.png',
                //                       color: MyColor.customColor,
                //                       scale: 4,
                //                     )
                //                   : Image.network(
                //                       userProvider.userModel.profileImg,
                //                       fit: BoxFit.cover,
                //                     )))),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   '${userProvider.userModel.name}',
                //   style: TextStyle(color: MyColor.customColor),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Card(
                  color: MyColor.customColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => Profile(
                                    userModel: userProvider.userModel,
                                  )));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          (userProvider.userModel.profileImg == null)
                              ? AssetImage(
                                  'assets/profile.png',
                                )
                              : NetworkImage(userProvider.userModel.profileImg),
                    ),
                    title: Text(
                      '${userProvider.userModel.name}',
                      style: TextStyle(color: MyColor.whiteColor),
                    ),
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (ctx) => Profile(
                            //               userModel: userProvider.userModel,
                            //             )));
                          },
                          trailing: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: MyColor.customColor)),
                            child: ToggleSwitch(
                              minWidth: 70.0,
                              cornerRadius: 10.0,
                              activeBgColor: MyColor.customColor,
                              activeFgColor: Colors.white,
                              initialLabelIndex:
                                  (local.locale.languageCode == "en") ? 0 : 1,
                              inactiveBgColor: Colors.white,
                              inactiveFgColor: MyColor.customColor,
                              labels: ['العربية', 'الإنجليزية'],
                              onToggle: (index) {
                                if (local.locale.languageCode == "en") {
                                  locProvider.changeLanguage(Locale('ar'));
                                } else {
                                  locProvider.changeLanguage(Locale('en'));
                                }
                                print('switched to: $index');
                              },
                            ),
                          ),
                          leading: Icon(
                            Icons.language,
                            size: 25,
                            color: MyColor.customColor,
                          ),
                          title: Text(
                            'اللغة',
                            style: TextStyle(color: MyColor.customColor),
                          ),
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
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (ctx) => SendMsg()));
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
                          color: Colors.grey,
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
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => AddAboutUs()));
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
                        Divider(color: Colors.grey),
                        ListTile(
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctxt) => AddContactUs()));
                          },
                          leading: Icon(
                            Icons.phone_android,
                            size: 20,
                            color: MyColor.customColor,
                          ),
                          title: Text(
                            'اتصل بنا',
                            style: TextStyle(color: MyColor.customColor),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                          onTap: () async {
                            showMyDialog(
                                context: context, msg: 'جاري تسجيل الخروج');
                            await logoutUser().then((value) {
                              dismissDialog(context);
                              if (value == true) {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => Login()));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
