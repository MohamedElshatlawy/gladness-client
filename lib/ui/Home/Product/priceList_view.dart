import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/API/products.dart';
import 'package:qutub_clinet/models/productModel.dart';
import 'package:qutub_clinet/models/vendorModel.dart';
import 'package:qutub_clinet/ui/widgets/customButton.dart';
import 'package:qutub_clinet/ui/widgets/snackBarAndDialog.dart';

import '../../colors.dart';

class PriceListView extends StatefulWidget {
  VendorModel vendorModel;
  PriceListView(this.vendorModel);
  @override
  _PriceListViewState createState() => _PriceListViewState();
}

class _PriceListViewState extends State<PriceListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.customGreyColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyColor.customColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: MyColor.whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Text(
              "قائمة اسعار",
              style: TextStyle(color: MyColor.customColor),
            ),
            SizedBox(
              width: 5,
            ),
            Text(widget.vendorModel.name, style: TextStyle(color: MyColor.customColor))
          ],
        ),
        centerTitle: true,
      ),
         body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            margin: EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
              stream:FirebaseFirestore.instance
                  .collection(MyCollections.products)
                  .where("vendorID", isEqualTo: widget. vendorModel.id)
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
                        "Len:${snapSHot.data.docs[0].data()['priceList'].length}");
                    return (snapSHot.data.docs.isEmpty)
                        ? Center(
                            child: Text('لا يوجد قائمة اسعار'),
                          )
                        : Column(
                            children: <Widget>[
                           
                              Expanded(
                                child: ListView.builder(
                                  
                                    itemCount: snapSHot.data.docs[0]
                                        .data()['priceList'].length,
                                    itemBuilder: (ctx, index) {
                                      var prodModel = ProductModel.fromJson(
                                          id: snapSHot
                                              .data.docs[0].id,
                                          json:
                                              snapSHot.data.docs[0].data());
                                     return Card(
                                                                            child: ListTile(
                                         title: Text(prodModel.priceList.keys.toList()[index]),
                                         trailing: Container(
                                           padding: EdgeInsets.all(8),
                                           decoration: BoxDecoration(
                                             color: Colors.red[800],
                                             borderRadius: BorderRadius.circular(6)
                                           ),
                                           child: Text(prodModel.priceList.values.toList()[index]+" ريال",
                                           style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 15
                                           ),
                                           )),
                                         
                                       ),
                                     );
                                    }),
                              ),
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

