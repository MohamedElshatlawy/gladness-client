import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/Providers/bottomNavProvider.dart';
import 'package:qutub_clinet/models/categoryModel.dart';
import 'package:qutub_clinet/ui/colors.dart';

import '../../Locale/appLocalization.dart';
import 'Category/customHomeCategoriesItem.dart';
import 'myCliper.dart';

class Welcome extends StatefulWidget {
  var homeKey;
  Welcome({this.homeKey});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var bottomNavProvider = Provider.of<BottomNavProvider>(context);
        var local = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.customGreyColor,
        body: Container(
            child: Column(
          children: [
            ClipPath(
              clipper: BezierClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColor.custGrey2,
                ),
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 3 + 40,
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Gladness",
                      style: TextStyle(
                          fontFamily: 'italy',
                          fontSize: 30,
                          color: MyColor.customColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      local.translate('home_desc'),
                       textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'ar',
                          fontSize: 12,
                          color: MyColor.customColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                     textDirection: (local.locale.languageCode=="en")?
                     TextDirection.rtl:TextDirection.ltr
                     ,
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            bottomNavProvider.onTapClick(1);
                          },
                          color: MyColor.customColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(15)),
                          child: Text(local.translate("home_viewall_btn")),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(MyCollections.categories)
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapSHot) {
                  if (snapSHot.hasError)
                    return new Text('خطأ: ${snapSHot.error}');
                  switch (snapSHot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.none:
                      return Center(
                        child: Text('لايوجد اتصال بالأنترنت'),
                      );
                    case ConnectionState.active:

                    case ConnectionState.done:
                      return (snapSHot.data.docs.isEmpty)
                          ? Center(
                              child: Text('لا يوجد أقسام'),
                            )
                          : ListView.separated(
                              separatorBuilder: (ctx, index) => SizedBox(
                                height: 15,
                              ),
                              itemCount: 2,
                              itemBuilder: (ctx, index) {
                                CategoryModel model = CategoryModel(
                                    id: snapSHot.data.docs[index].id,
                                    name: snapSHot.data.docs[index]
                                        .data()['name'],
                                    imgPath: snapSHot.data.docs[index]
                                        .data()['imgPath']);
                                return CategoryItem(
                                  categoryModel: model,
                                  index: index,
                                );
                              },
                            );
                  }
                  return Container();
                },
              ),
            ))
          ],
        )),
      ),
    );
  }
}
