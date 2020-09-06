import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/models/categoryModel.dart';
import 'package:qutub_clinet/models/vendorModel.dart';

import '../../colors.dart';
import 'categoryVendorItem.dart';

class CategoryVendors extends StatelessWidget {
  CategoryModel categoryModel;
  CategoryVendors({this.categoryModel});
  @override
  Widget build(BuildContext context) {
   print('Ben');

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
        title: Text(
          categoryModel.name,
          style: TextStyle(color: MyColor.customColor),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            margin: EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(MyCollections.vendors)
                  .where('categoryID', isEqualTo: categoryModel.id)
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
                            child: Text('لا يوجد تجار'),
                          )
                        : ListView.separated(
                            separatorBuilder: (ctx,index)=>SizedBox(height: 15,),
                            itemCount: snapSHot.data.docs.length,
                            itemBuilder: (ctx, index) {
                              var vendorModel = VendorModel.fromJson(
                                  id: snapSHot.data.docs[index].id, 
                                  json: snapSHot.data.docs[index].data());
                              return CategoryVendorItem( 
                                index: index,
                                vendorModel: vendorModel,
                              );
                            });
                }
                return Container();
              },
            )),
      ),
    );
  }
}
