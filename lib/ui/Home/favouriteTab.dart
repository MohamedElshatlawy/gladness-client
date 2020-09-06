import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutub_clinet/API/CommonCollections.dart';
import 'package:qutub_clinet/Providers/userProvider.dart';
import 'package:qutub_clinet/models/productModel.dart';

import '../setupGridItemSize.dart';
import 'favourite/favouriteProductItem.dart';

class FavouriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gridItem = GridItemSize(context, 243);

    var userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(MyCollections.userCollection)
          .doc(userProvider.userModel.userToken)
          .collection(MyCollections.favourite)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapSHot) {
        if (snapSHot.hasError) return new Text('خطأ: ${snapSHot.error}');
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
                    child: Text(''),
                  )
                : Container(
                    child: GridView.builder(
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: gridItem.aspectRatio),
                        itemCount: snapSHot.data.docs.length,
                        itemBuilder: (ctx, index) {
                          var prodModel = ProductModel.fromJson(
                              id: snapSHot.data.docs[index].id,
                              json: snapSHot.data.docs[index].data());
                          return FavouriteProductItem(
                            productModel: prodModel,
                          );
                        }),
                  );
        }
        return Container();
      },
    );
  }
}
