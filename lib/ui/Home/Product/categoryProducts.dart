import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/models/categoryModel.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/Home/Product/priceList_view.dart';
import 'package:qutub_clinet/ui/Home/Product/reservation.dart';
import 'package:qutub_clinet/ui/setupGridItemSize.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../colors.dart';
import 'categoryProductsItem.dart';

class CategoryProducts extends StatelessWidget {
  VendorModel vendorModel;
  CategoryProducts({this.vendorModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      appBar: AppBar(
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(Icons.more_vert),
          //     color: MyColor.customColor,
          //     onPressed: () {
          //       // showMenu(
          //       //   context: context,
          //       //   position: RelativeRect.fromLTRB(20, 10, 10, 0),
          //       //   items: [
          //       //     PopupMenuItem<String>(
          //       //       child: InkWell(
          //       //           onTap: () {
          //       //             dismissDialog(context);
          //       //             Navigator.push(
          //       //                 context,
          //       //                 MaterialPageRoute(
          //       //                     builder: (ctx) =>
          //       //                         PriceListView(vendorModel)));
          //       //           },
          //       //           child: Text('قائمة الأسعار')),
          //       //     ),
          //       //     PopupMenuItem<String>(
          //       //       child: InkWell(
          //       //           onTap: () {
          //       //             dismissDialog(context);
          //       //             Navigator.push(
          //       //                 context,
          //       //                 MaterialPageRoute(
          //       //                     builder: (ctx) =>
          //       //                         HolidaysView(vendorModel)));
          //       //           },
          //       //           child: Text('موعيد الأجازات')),
          //       //     )
          //       //   ],
          //       // );
          //     })
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColor.customColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: MyColor.whiteColor,
        title: Text(vendorModel.name,
            style: TextStyle(color: MyColor.customColor)),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            margin: EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(MyCollections.products)
                  .where("vendorID", isEqualTo: vendorModel.id)
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
                    print(
                        "Len:${snapSHot.data.docs[0].data()['gallery'].length}");
                    return (snapSHot.data.docs.isEmpty)
                        ? Center(
                            child: Text('لا يوجد صور'),
                          )
                        : Column(
                            children: <Widget>[
                              Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    itemCount: snapSHot.data.docs[0]
                                        .data()['gallery']
                                        .length,
                                    itemBuilder: (ctx, index) {
                                      var prodModel = ProductModel.fromJson(
                                          id: snapSHot.data.docs[0].id,
                                          json: snapSHot.data.docs[0].data());
                                      return CategoryProductItem(
                                        productModel: prodModel,
                                        index: index,
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 150,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                Reservation(vendorModel)));
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: Colors.white,
                                  textColor: MyColor.customColor,
                                  child: Text('حجز الخدمة'),
                                ),
                              )
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: CustomButton(
                              //         backgroundColor: MyColor.customColor,
                              //         btnPressed: () {
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (ctx) =>
                              //                       Reservation(vendorModel)));
                              //         },
                              //         textColor: Colors.white,
                              //         txt: 'حجز الخدمة',
                              //       ),
                              //     ),
                              //     // SizedBox(
                              //     //   width: 15,
                              //     // ),
                              //     // Expanded(
                              //     //   child: CustomButton(
                              //     //     backgroundColor: MyColor.customColor,
                              //     //     btnPressed: () {
                              //     //       Navigator.push(
                              //     //           context,
                              //     //           MaterialPageRoute(
                              //     //               builder: (ctx) => PriceListView(
                              //     //                   vendorModel)));
                              //     //     },
                              //     //     textColor: Colors.white,
                              //     //     txt: 'قائمة الأسعار',
                              //     //   ),
                              //     // ),
                              //   ],
                              // )
                            ],
                          );
                }
                return Container();
              },
            )),
      ),
    );
  }
}
